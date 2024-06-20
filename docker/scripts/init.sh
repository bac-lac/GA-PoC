#!/bin/bash

#######################################
# Main function
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   None
#######################################
function main() {
    echo "Main function"    
    # Exit script when any command fails
    set -e
    # Keep track of the last executed command
    trap 'last_command=${BASH_COMMAND}' DEBUG
    # Echo an error message before exiting
    # shellcheck disable=SC2154
    trap 'echo "\"${last_command}\" command failed with exit code $?." >&2' EXIT

    wait_for_mount_availability
    wait_for_database_service_availability
    create_database_and_credentials
    configure
    start

    # Remove DEBUG and EXIT trap
    trap - DEBUG
    trap - EXIT
    # Allow script to continue on error.
    set +e
}

#######################################
# Wait until the file service becomes mounted to prevent installation
# failure. Fails if the file service is not mounted after 30 seconds.
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   None
#######################################
function wait_for_mount_availability() {
    echo "Wait for mount"
    readonly MOUNT_MAX_WAIT=30    

    # Local variables
    local mount_ping_statement
    local wait_time

    echo "Checking if file service is mounted..."

    mount_ping_statement="mountpoint -q /opt/HelpSystems/GoAnywhere/userdata/"

    # Wait for mount readiness.
    wait_time=0
    until ${mount_ping_statement}; do
        if [[ ${wait_time} -ge ${MOUNT_MAX_WAIT} ]]; then
            echo "The file service did not mount within ${wait_time} s. Aborting."
            exit 1
        else
            echo "Waiting for the file service to mount (${wait_time} s)..."
            sleep 1
            ((++wait_time))
        fi
    done
    echo "File service is mounted."
}

#######################################
# Wait until a given database service becomes available.
# Fail if the database service is not availble after a given duration.
# Globals:
#   DB_ADDRESS
# Arguments:
#   None
# Outputs:
#   None
#######################################
function wait_for_database_service_availability() {
    echo "Wait for database"
    # Parameters
    local database_host="$DB_ADDRESS"
    local maximum_wait="15"
    local database_port="3306"

    # Variables
    local wait_time

    echo "Pinging database service ${database_host}:${database_port} until readiness for a maximum of ${maximum_wait} seconds..."
    wait_time=0
    until mysqladmin ping --host "${database_host}" --port "${database_port}" --silent; do
        if [[ ${wait_time} -ge ${maximum_wait} ]]; then
            echo "The database service did not start within ${wait_time} s. Aborting."
            exit 1
        else
            echo "Waiting for the database service to start (${wait_time} s)..."
            sleep 1
            ((++wait_time))
        fi
    done
    echo "Database service is up and running."
}

#######################################
# Create Database and Credentials
# Globals:
#   ADMIN_DB_PASSWORD
#   ADMIN_DB_USERNAME
#   DB_ADDRESS
#   DB_PASSWORD
#   DB_USERNAME
# Arguments:
#   None
# Outputs:
#   None
#######################################
function create_database_and_credentials() {
    echo "Create Database"

    # check if the database already exists
    result=$(mysql -h $DB_ADDRESS -u$ADMIN_DB_USERNAME -p$ADMIN_DB_PASSWORD -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='GADATA'" 2>&1)
    echo "result=$result"
    if [ -z "$result" ]; then 
        echo "Database does not exists";

        echo "Creating MySQL database if not existing..."
        echo "$(mysql -h $DB_ADDRESS -u$ADMIN_DB_USERNAME -p$ADMIN_DB_PASSWORD --execute "WARNINGS; CREATE DATABASE IF NOT EXISTS 'GADATA' CHARSET=UTF8;")"

        echo "Creating MySQL database user if not existing..."
        echo "$(mysql -h $DB_ADDRESS -u$ADMIN_DB_USERNAME -p$ADMIN_DB_PASSWORD --execute "WARNINGS; CREATE USER IF NOT EXISTS '$DB_USERNAME' IDENTIFIED BY '$DB_PASSWORD';")"

        echo "Granting all privileges on MySQL database objects to user..."
        echo "$(mysql -h $DB_ADDRESS -u$ADMIN_DB_USERNAME -p$ADMIN_DB_PASSWORD --execute "WARNINGS; GRANT ALL PRIVILEGES ON GADATA.* TO '$DB_USERNAME';")"

        echo "Importing empty database..."
        echo "$(mysql -h $DB_ADDRESS -u$ADMIN_DB_USERNAME -p$ADMIN_DB_PASSWORD < /temp/mysql_dump.sql)"
    else
        echo "Database exists";
    fi

}

#######################################
# Configure the application
# Globals:
#   DB_PASSWORD
#   DB_USERNAME
#   DB_URL
# Arguments:
#   None
# Outputs:
#   None
#######################################
function configure() {
    echo "Configure"

    # Variables.
    local config_folder="/etc/HelpSystems/GoAnywhere/config"
    local shareconfig_folder="/etc/HelpSystems/GoAnywhere/sharedconfig"

    echo "Copy filesystem"
    cp -rn /temp/userdata/ /opt/HelpSystems/GoAnywhere/
    cp -rn /temp/upgrader/ /opt/HelpSystems/GoAnywhere/
    cp -rn /temp/config/ /etc/HelpSystems/GoAnywhere/
    cp -rn /temp/tomcat/ /etc/HelpSystems/GoAnywhere/
    cp -rn /temp/logs/ /opt/HelpSystems/GoAnywhere/tomcat/
    cp -rn /temp/custom/ /opt/HelpSystems/GoAnywhere/ghttpsroot/

    # Copy config files to the shared folder.
    cp -rn /temp/config/*.xml "${shareconfig_folder}"

    # Remove "update default database location" in the entrypoint
    echo "Update entrypoint"
    sed -i '14,15d' /temp/entrypoint.sh 

    # Update the file database.xml with the correct values.
    echo "Update database config"
    sed -i "s|password\">.*<|password\">$DB_PASSWORD<|g" "${shareconfig_folder}"/database.xml
    sed -i "s|username\">.*<|username\">$DB_USERNAME<|g" "${shareconfig_folder}"/database.xml
    sed -i "s|url\">.*<|url\">jdbc:mariadb://$DB_ADDRESS:3306/GADATA?useCursorFetch=true\&amp;defaultFetchSize=20\&amp;characterEncoding=utf8<|g" "${shareconfig_folder}"/database.xml
    sed -i "s|driverClassName\">.*<|driverClassName\">org.mariadb.jdbc.Driver<|g" "${shareconfig_folder}"/database.xml
    sed -i "s|passwordIsEncrypted\">.*<|passwordIsEncrypted\">false<|g" "${shareconfig_folder}"/database.xml

    # Creating symbolic link for application configuration files.
    echo "Create symbolic link"
    cd "${config_folder}"
    cp cluster.xml /tmp/cluster.xml
    rm -rf *
    cp /tmp/cluster.xml .
    ln -s "${shareconfig_folder}"/database.xml "${config_folder}"/database.xml
    ln -s "${shareconfig_folder}"/agent.xml "${config_folder}"/agent.xml
    ln -s "${shareconfig_folder}"/ftp.xml "${config_folder}"/ftp.xml
    ln -s "${shareconfig_folder}"/ftps.xml "${config_folder}"/ftps.xml
    ln -s "${shareconfig_folder}"/gateway.xml "${config_folder}"/gateway.xml
    ln -s "${shareconfig_folder}"/gofast.xml "${config_folder}"/gofast.xml
    ln -s "${shareconfig_folder}"/https.xml "${config_folder}"/https.xml
    ln -s "${shareconfig_folder}"/log4j2.xml "${config_folder}"/log4j2.xml
    ln -s "${shareconfig_folder}"/pesit.xml "${config_folder}"/pesit.xml
    ln -s "${shareconfig_folder}"/security.xml "${config_folder}"/security.xml
    ln -s "${shareconfig_folder}"/sftp.xml "${config_folder}"/sftp.xml

}

#######################################
# Start application
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   None
#######################################
function start() {

    echo "Start application"

    exec /temp/entrypoint.sh

}

main 