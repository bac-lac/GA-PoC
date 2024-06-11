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
  && yum -y install procps unzip epel-release jq\
  && yum -y clean all \
  && rm -rf /var/cache

# Installing pip. 
RUN python3 -m ensurepip

USER gamft
