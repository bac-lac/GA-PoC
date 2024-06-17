FROM helpsystems/goanywhere-mft:latest as builder


FROM helpsystems/goanywhere-mft:latest
USER root
WORKDIR /tmp
COPY --from=builder /opt/HelpSystems/GoAnywhere/userdata/ userdata/
COPY --from=builder /opt/HelpSystems/GoAnywhere/upgrader/ upgrader/ 
COPY --from=builder /etc/HelpSystems/GoAnywhere/config/ config/
COPY --from=builder /etc/HelpSystems/GoAnywhere/tomcat/ tomcat/
COPY --from=builder /opt/HelpSystems/GoAnywhere/tomcat/logs/ logs/
COPY --from=builder /opt/HelpSystems/GoAnywhere/ghttpsroot/custom/ custom/
COPY --from=builder /usr/bin/entrypoint.sh .

COPY scripts/init.sh /usr/bin/
RUN chmod -R 554 /usr/bin/init.sh
RUN chmod -R 777 /tmp

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

# Installing dependencies.
RUN yum update -y \
  && yum -y install procps unzip epel-release \
  && yum -y clean all \
  && rm -rf /var/cache

USER gamft

ENTRYPOINT [ "/usr/bin/init.sh" ]