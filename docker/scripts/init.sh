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

    copy_filesystem
    configure_propeties
    start_app

    echo "Main completed"
}

#######################################
# Copy filesystem to mount drive if it doesn't exists.
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   None
#######################################
function copy_filesystem() {
    echo "Copy filesystem"
    ls -la /tmp
    cp -rn /tmp/userdata/ /opt/HelpSystems/GoAnywhere/userdata/
    cp -rn /tmp/upgrader/ /opt/HelpSystems/GoAnywhere/upgrader/
    cp -rn /tmp/config/ /etc/HelpSystems/GoAnywhere/config/
    cp -rn /tmp/tomcat/ /etc/HelpSystems/GoAnywhere/tomcat/
    cp -rn /tmp/logs/ /opt/HelpSystems/GoAnywhere/tomcat/logs/
    cp -rn /tmp/custom/ /opt/HelpSystems/GoAnywhere/ghttpsroot/custom/


    echo "temp config"
    ls -la /tmp/config/
    echo "real config"
    ls -la /etc/HelpSystems/GoAnywhere/config/

    # Copy config files to the shared folder.
    cp /tmp/config/*.xml /etc/HelpSystems/GoAnywhere/sharedconfig
    echo "ls -la /etc/HelpSystems/GoAnywhere/sharedconfig"
    ls -la /etc/HelpSystems/GoAnywhere/sharedconfig

    echo "Copy filesystem completed"
}

#######################################
# Configure properties files
# Globals:
#   CLUSTER_PORT
#   DB_PASSWORD
#   DB_USERNAME
#   DB_URL
# Arguments:
#   None
# Outputs:
#   None
#######################################
function configure_propeties() {
    echo "Configure properties"

    # Variables.
    config_folder="/etc/HelpSystems/GoAnywhere/config"
    program_folder="/opt/HelpSystems/GoAnywhere"
    shareconfig_folder="/etc/HelpSystems/GoAnywhere/sharedconfig"
    entrypoint="/usr/bin/entrypoint.sh"

    cd "${program_folder}"
    echo "ls -la /temp"
    ls -la /temp
    # Remove update logic in the entrypoint
    sed -i '14d' /temp/entrypoint.sh
    #sed -i 'echo "Updating default database location..."' /tmp/entrypoint.sh
    #sed -i "sed -i 's|/usr/local/HelpSystems/GoAnywhere|/opt/HelpSystems/GoAnywhere|g' /etc/HelpSystems/GoAnywhere/config/database.xml" /tmp/entrypoint.sh
    
    # Update the cluster logic in the entrypoint.
    sed -i "s|clusterBindPort\">8006<|clusterBindPort\">$CLUSTER_PORT<|g" /temp/entrypoint.sh


    echo "cat /temp/entrypoint.sh"
    cat /temp/entrypoint.sh


    echo "ls -la ${config_folder}"
    ls -la "${config_folder}"
    

    # Update the file database.xml with the correct values.
    sed -i "s|password\">.*<|password\">$DB_PASSWORD<|g" "${shareconfig_folder}"/database.xml
    sed -i "s|username\">.*<|username\">$DB_USERNAME<|g" "${shareconfig_folder}"/database.xml
    sed -i "s|url\">.*<|url\">$DB_URL<|g" "${shareconfig_folder}"/database.xml

    echo "database.xml"
    cat "${shareconfig_folder}"/database.xml

    # Creating symbolic link for application configuration files.
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

    echo "Configure properties completed"
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
function start_app() {
    echo "Start application"

    exec /usr/bin/entrypoint.sh

}

main 