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

# Update login from GoAnywhere.
# Update will always run if the file ga_upgrade.jar is present.
if [ -f "upgrader/ga_upgrade.jar" ]
then
  echo "Running upgrader..."
  java -classpath upgrader/ga_upgrade.jar -javaagent:upgrader/ga_upgrade.jar com.linoma.goanywhere.upgrader.Startup skipFiles
  if [ $? -eq 0 ]
  then
    mv upgrader/ga_upgrade.jar upgrader/ga_upgrade_complete.jar
  fi
  else
  echo "No upgrade file found, skipping upgrade command"
fi

# Update the file cluster.xml with the host values.
if [ "$MFT_CLUSTER" == "TRUE" ]; then
  host=`hostname -i`
  echo "CLUTER PORT: $CLUSTER_PORT"
  sed -i "s|systemName\">.*<|systemName\">$SYSTEM_NAME<|g" "${config_folder}"/cluster.xml
  sed -i "s|clusterBindAddress\">.*<|clusterBindAddress\">$host<|g" "${config_folder}"/cluster.xml
  sed -i "s|clusterBindPort\">.*<|clusterBindPort\">$CLUSTER_PORT<|g" "${config_folder}"/cluster.xml
  sed -i "s|false|true|g" "${config_folder}"/cluster.xml
fi

# Update the file database.xml with the correct values.
sed -i "s|password\">.*<|password\">$DB_PASSWORD<|g" "${shareconfig_folder}"/database.xml
sed -i "s|username\">.*<|username\">$DB_USERNAME<|g" "${shareconfig_folder}"/database.xml
sed -i "s|url\">.*<|url\">$DB_URL<|g" "${shareconfig_folder}"/database.xml

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

exec "$program_folder"/"$EXECUTABLE" run "$@"