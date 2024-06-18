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

COPY scripts/init.sh /temp/
RUN chmod -R 554 /temp/init.sh
RUN chmod -R 777 /temp/

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

# Installing dependencies.
RUN yum update -y \
  && yum -y install procps unzip epel-release \
  && yum -y clean all \
  && rm -rf /var/cache

USER gamft

ENTRYPOINT [ "/temp/init.sh" ]