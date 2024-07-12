FROM helpsystems/goanywhere-mft:latest as builder


FROM helpsystems/goanywhere-mft:latest
USER root
WORKDIR /temp
COPY --from=builder /opt/HelpSystems/GoAnywhere/userdata/ userdata/
COPY --from=builder /opt/HelpSystems/GoAnywhere/upgrader/ upgrader/ 
COPY --from=builder /etc/HelpSystems/GoAnywhere/config/ config/
COPY --from=builder /etc/HelpSystems/GoAnywhere/tomcat/ tomcat/
COPY --from=builder /opt/HelpSystems/GoAnywhere/tomcat/logs/ logs/
COPY --from=builder /opt/HelpSystems/GoAnywhere/ghttpsroot/custom/ custom/
COPY --from=builder /usr/bin/entrypoint.sh /temp/

COPY mysql_dump.sql /temp/mysql_dump.sql

COPY scripts/init.sh /temp/
RUN chmod -R 777 /temp/

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

RUN yum update -y \
  && yum -y install wget procps unzip epel-release \
  && yum -y clean all \
  && rm -rf /var/cache

RUN dnf update -y \
  && curl -O https://dev.mysql.com/get/mysql84-community-release-el9-1.noarch.rpm \
  && dnf install mysql84-community-release-el9-1.noarch.rpm -y \
  && dnf install mysql-community-client -y

USER gamft

ENTRYPOINT [ "/temp/init.sh" ]