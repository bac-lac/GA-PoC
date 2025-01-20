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

    mount_ping_statement="mountpoint -q /opt/Fortra/GoAnywhere/userdata/"

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
# Fail if the database service is not available after a given duration.
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
    local database_port="3306"
    local maximum_wait="15"

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
#   FORCE_REFRESH
# Arguments:
#   None
# Outputs:
#   None
#######################################
function create_database_and_credentials() {
    echo "Create Database"

    # Drop database if FORCE_REFRESH is true
    if [[ $FORCE_REFRESH == "true" ]]; then 
        echo "Drop MySQL database..."
        mysql -h "$DB_ADDRESS" -u"$ADMIN_DB_USERNAME" -p"$ADMIN_DB_PASSWORD" --execute "WARNINGS; DROP DATABASE IF EXISTS \`GADATA\`;"

        echo "Deleting MySQL database user..."
        mysql -h "$DB_ADDRESS" -u"$ADMIN_DB_USERNAME" -p"$ADMIN_DB_PASSWORD" --execute "WARNINGS; DROP USER IF EXISTS \`$DB_USERNAME\`;"
    fi

    # check if the database already exists
    result=$(mysql -h "$DB_ADDRESS" -u"$ADMIN_DB_USERNAME" -p"$ADMIN_DB_PASSWORD" -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='GADATA'" 2>&1)
    if [[ $result =~ "GADATA" ]]; then 
        echo "Database exists";
    else
        echo "Database does not exists";
        echo "Creating MySQL database if not existing..."
        mysql -h "$DB_ADDRESS" -u"$ADMIN_DB_USERNAME" -p"$ADMIN_DB_PASSWORD" --execute "WARNINGS; CREATE DATABASE IF NOT EXISTS \`GADATA\` CHARSET=UTF8;"

        echo "Creating MySQL database user if not existing..."
        mysql -h "$DB_ADDRESS" -u"$ADMIN_DB_USERNAME" -p"$ADMIN_DB_PASSWORD" --execute "WARNINGS; CREATE USER IF NOT EXISTS \`$DB_USERNAME\` IDENTIFIED BY '$DB_PASSWORD';"

        echo "Granting all privileges on MySQL database objects to user..."
        mysql -h "$DB_ADDRESS" -u"$ADMIN_DB_USERNAME" -p"$ADMIN_DB_PASSWORD" --execute "WARNINGS; GRANT ALL PRIVILEGES ON \`GADATA\`.* TO \`$DB_USERNAME\`;"

        echo "Importing empty database..."
        mysql -h "$DB_ADDRESS" -u"$ADMIN_DB_USERNAME" -p"$ADMIN_DB_PASSWORD" < /temp/mysql_dump.sql
    fi

}

#######################################
# Configure the application
# Globals:
#   BRANCH_NAME
#   DB_ADDRESS
#   DB_PASSWORD
#   DB_USERNAME
#   ECR_IMAGE
#   FRESH_INSTALL
# Arguments:
#   None
# Outputs:
#   None
#######################################
function configure() {
    echo "Configure"

    # Variables.
    local etc_ga_folder="/etc/Fortra/GoAnywhere"
    local opt_ga_folder="/opt/Fortra/GoAnywhere"
    local config_folder="${etc_ga_folder}/config"
    local shareconfig_folder="${etc_ga_folder}/sharedconfig"

    # Copy filesystem only if FRESH_INSTALL is true
    echo "FRESH_INSTALL -> ${FRESH_INSTAL}"
    if [[ $FRESH_INSTALL == "true" ]]; then 
        echo "Copy filesystem"
        cp -rf /temp/userdata/ "${opt_ga_folder}"/
        cp -rf /temp/upgrader/ "${opt_ga_folder}"/
        cp -rf /temp/config/ "${etc_ga_folder}"/
        cp -rf /temp/tomcat/ "${etc_ga_folder}"/
        cp -rf /temp/logs/ "${opt_ga_folder}"/tomcat/
        cp -rf /temp/custom/ "${opt_ga_folder}"/ghttpsroot/

        # Copy config files to the shared folder.
        echo "Copy config files to the shared folder"
        cp -rf /temp/config/*.xml "${shareconfig_folder}"

        # Creating symbolic link for application configuration files.
        echo "Creating symbolic link for application configuration files"
        ln -s "${shareconfig_folder}"/agent.xml "${config_folder}"/agent.xml
        ln -s "${shareconfig_folder}"/database.xml "${config_folder}"/database.xml
        ln -s "${shareconfig_folder}"/filecatalyst.xml "${config_folder}"/filecatalyst.xml
        ln -s "${shareconfig_folder}"/ftp.xml "${config_folder}"/ftp.xml
        ln -s "${shareconfig_folder}"/ftps.xml "${config_folder}"/ftps.xml
        ln -s "${shareconfig_folder}"/gateway.xml "${config_folder}"/gateway.xml
        ln -s "${shareconfig_folder}"/gofast.xml "${config_folder}"/gofast.xml
        ln -s "${shareconfig_folder}"/https.xml "${config_folder}"/https.xml
        ln -s "${shareconfig_folder}"/log4j2.xml "${config_folder}"/log4j2.xml
        ln -s "${shareconfig_folder}"/pesit.xml "${config_folder}"/pesit.xml
        ln -s "${shareconfig_folder}"/security.xml "${config_folder}"/security.xml
        ln -s "${shareconfig_folder}"/sftp.xml "${config_folder}"/sftp.xml

    fi

    # Remove "update default ports" in the entrypoint
    echo "Update entrypoint"
    sed -i '9,14d' /temp/entrypoint.sh

    # Update hostname in entrypoint
    echo "Update hostname in entrypoint"
    sed -i "s/\$HOSTNAME/\$SYSTEM_NAME-\$host/g" /temp/entrypoint.sh

    # Update the file database.xml with the correct values.
    echo "Update database config"
    sed -i "s|password\">.*<|password\">$DB_PASSWORD<|g" "${shareconfig_folder}"/database.xml
    sed -i "s|username\">.*<|username\">$DB_USERNAME<|g" "${shareconfig_folder}"/database.xml
    sed -i "s|url\">.*<|url\">jdbc:mariadb://$DB_ADDRESS:3306/GADATA?useCursorFetch=true\&amp;defaultFetchSize=20\&amp;characterEncoding=utf8<|g" "${shareconfig_folder}"/database.xml
    sed -i "s|driverClassName\">.*<|driverClassName\">org.mariadb.jdbc.Driver<|g" "${shareconfig_folder}"/database.xml
    sed -i "s|passwordIsEncrypted\">.*<|passwordIsEncrypted\">false<|g" "${shareconfig_folder}"/database.xml

    # Update the header's page with build values.
    local meta_param1="<meta name=\"BRANCH_NAME\" content=\"${BRANCH_NAME}\" />"
    local meta_param2="<meta name=\"ECR_IMAGE\" content=\"${ECR_IMAGE}\" />"
    sed -i "s|<meta name=\"viewport\"|${meta_param1}${meta_param2}<meta name=\"viewport\"|g" "${opt_ga_folder}"/adminroot/WEB-INF/includes/DocumentHead.xhtml

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
