FROM helpsystems/goanywhere-mft:latest as builder


FROM helpsystems/goanywhere-mft:latest
USER root
WORKDIR /tmp
COPY --from=builder /opt/HelpSystems/GoAnywhere/userdata/ .
COPY --from=builder /opt/HelpSystems/GoAnywhere/upgrader/ .
COPY --from=builder /etc/HelpSystems/GoAnywhere/config/ .
COPY --from=builder /etc/HelpSystems/GoAnywhere/tomcat/ .
COPY --from=builder /opt/HelpSystems/GoAnywhere/tomcat/logs/ .
COPY --from=builder /opt/HelpSystems/GoAnywhere/ghttpsroot/custom/ .

COPY scripts/init.sh /usr/bin/

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

# Installing dependencies.
RUN yum update -y \
  && yum -y install procps unzip epel-release \
  && yum -y clean all \
  && rm -rf /var/cache

USER gamft

ENTRYPOINT [ "/usr/bin/init.sh" ]