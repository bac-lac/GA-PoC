#!/bin/bash

set -e

echo "********************************************"
echo "********************************************"
echo "********************************************"
echo "********************************************"
echo ""
echo ""
echo "........CUSTOM ENTRYPOINT........"
echo ""
echo ""
echo "********************************************"
echo "********************************************"
echo "********************************************"
echo "********************************************"

echo ""
echo "IS_PR name: $IS_PR"
echo ""
if [ "$IS_PR" = true ]; then
  echo "Import Database"

 
  sed -e "s/\${DB_USERNAME}/$DB_USERNAME/" -e "s/\${DB_PASSWORD}/$DB_PASSWORD/" /tmp/sql/mysql_dump.sql > /tmp/mysql_dump.sql
  
  # result=$(mysql -h $DB_ADDRESS -u$ADMIN_DB_USERNAME -p$ADMIN_DB_PASSWORD -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='GADATA'"); 
  # if [ -z "$result" ]; then 
  #   echo "db does not exists";
  # else
  #   echo "db exists";
  # fi

  # mysql -h $DB_ADDRESS -u$ADMIN_DB_USERNAME -p$ADMIN_DB_PASSWORD < /tmp/mysql_dump.sql
fi


# Variables.
config_folder="/etc/HelpSystems/GoAnywhere/config"
program_folder="/opt/HelpSystems/GoAnywhere"
shareconfig_folder="/etc/HelpSystems/GoAnywhere/sharedconfig"
tomcat_folder="/etc/HelpSystems/GoAnywhere/tomcat"

cd "${program_folder}"

# Copy temporary files to their default location.
cp /tmp/sharedconfig/*.xml "${shareconfig_folder}"
cp -R /tmp/sharedconfig/conf/ "${tomcat_folder}"
cp /tmp/sharedconfig/cluster.xml "${config_folder}"

pwd 
ls -la
ls -la upgrader
# Update login from GoAnywhere.
# Update will always run if the file ga_upgrade.jar is present.
if [ -f "upgrader/ga_upgrade.jar" ]
then
  echo "Running upgrader..."
  java -classpath upgrader/ga_upgrade.jar -javaagent:upgrader/ga_upgrade.jar com.linoma.goanywhere.upgrader.Startup skipFiles
  if [ $? -eq 0 ]
  then
    echo "Move upgrade jar..."
    mv upgrader/ga_upgrade.jar upgrader/ga_upgrade_complete.jar
  fi
  else
  echo "No upgrade file found, skipping upgrade command"
fi

# Update the file cluster.xml with the host values.
echo "Update the file cluster.xml with the host values."
if [ "$MFT_CLUSTER" == "TRUE" ]; then
  host=`hostname -i`
  sed -i "s|systemName\">.*<|systemName\">$SYSTEM_NAME<|g" "${config_folder}"/cluster.xml
  sed -i "s|clusterBindAddress\">.*<|clusterBindAddress\">$host<|g" "${config_folder}"/cluster.xml
  sed -i "s|clusterBindPort\">.*<|clusterBindPort\">$CLUSTER_PORT<|g" "${config_folder}"/cluster.xml
  sed -i "s|false|true|g" "${config_folder}"/cluster.xml
fi

# Update the file database.xml with the correct values.
echo "Update the file database.xml with the correct values."
sed -i "s|password\">.*<|password\">$DB_PASSWORD<|g" "${shareconfig_folder}"/database.xml
sed -i "s|username\">.*<|username\">$DB_USERNAME<|g" "${shareconfig_folder}"/database.xml
sed -i "s|url\">.*<|url\">jdbc:mariadb://$DB_ADDRESS:3306/GADATA?useCursorFetch=true\&amp;defaultFetchSize=20\&amp;characterEncoding=utf8<|g" "${shareconfig_folder}"/database.xml

# Creating symbolic link for application configuration files.
echo "Creating symbolic link for application configuration files."
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


echo "ls -la /opt/HelpSystems/GoAnywhere/userdata/logs/"
ls -la /opt/HelpSystems/GoAnywhere/userdata/logs/
echo "cat /opt/HelpSystems/GoAnywhere/userdata/logs/database.log"
cat /opt/HelpSystems/GoAnywhere/userdata/logs/database.log
echo "cat /opt/HelpSystems/GoAnywhere/userdata/logs/goanywhere.log"
cat /opt/HelpSystems/GoAnywhere/userdata/logs/goanywhere.log

JVM='1024'
if [ -n "$JAVA_MAX_MEMORY" ]; then
  JVM=$JAVA_MAX_MEMORY
fi

JAVA_OPTS="-Xmx"$JVM"m -XX:MaxMetaspaceSize=1024m -Djava.awt.headless=true"
export JAVA_OPTS

# Use the bundled JRE if one has been bundled.
if [ -d "$program_folder/jre6" ]
then
  export JAVA_HOME="$program_folder/jre6"
elif [ -d "$program_folder/jre" ]
then
  export JAVA_HOME="$program_folder/jre"
fi

EXECUTABLE=tomcat/bin/goanywhere_catalina.sh
echo "Execute Go Anywhere"
exec "$program_folder"/"$EXECUTABLE" run "$@"