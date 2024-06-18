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

    configure
    start

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
    cp -rn /temp/userdata/ /opt/HelpSystems/GoAnywhere/userdata/
    cp -rn /temp/upgrader/ /opt/HelpSystems/GoAnywhere/upgrader/
    cp -rn /temp/config/ /etc/HelpSystems/GoAnywhere/config/
    cp -rn /temp/tomcat/ /etc/HelpSystems/GoAnywhere/tomcat/
    cp -rn /temp/logs/ /opt/HelpSystems/GoAnywhere/tomcat/logs/
    cp -rn /temp/custom/ /opt/HelpSystems/GoAnywhere/ghttpsroot/custom/

    # Copy config files to the shared folder.
    cp -rn /temp/config/*.xml "${shareconfig_folder}"

    # Remove "update default database location" in the entrypoint
    echo "Update entrypoint"
    sed -i '14,15d' /temp/entrypoint.sh 

    # Update the file database.xml with the correct values.
    echo "Update database config"
    sed -i "s|password\">.*<|password\">$DB_PASSWORD<|g" "${shareconfig_folder}"/database.xml
    sed -i "s|username\">.*<|username\">$DB_USERNAME<|g" "${shareconfig_folder}"/database.xml
    sed -i "s|url\">.*<|url\">$DB_URL<|g" "${shareconfig_folder}"/database.xml
    sed -i "s|driverClassName\">.*<|driverClassName\">org.mariadb.jdbc.Driver<|g" "${shareconfig_folder}"/database.xml

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