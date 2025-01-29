FROM fortrallc/goanywhere-mft:7.7.0 as builder

FROM fortrallc/goanywhere-mft:7.7.0
USER root
WORKDIR /temp
COPY --from=builder /opt/Fortra/GoAnywhere/userdata/ userdata/
COPY --from=builder /opt/Fortra/GoAnywhere/upgrader/ upgrader/ 
COPY --from=builder /etc/Fortra/GoAnywhere/config/ config/
COPY --from=builder /etc/Fortra/GoAnywhere/tomcat/ tomcat/
COPY --from=builder /opt/Fortra/GoAnywhere/tomcat/logs/ logs/
COPY --from=builder /opt/Fortra/GoAnywhere/ghttpsroot/custom/ custom/
COPY --from=builder /usr/bin/entrypoint.sh /temp/

COPY mysql_dump.sql /temp/mysql_dump.sql

COPY /scripts/setenv.sh /opt/Fortra/GoAnywhere/tomcat/bin/

COPY /scripts/init.sh /temp/
RUN chmod -R 777 /temp/

COPY /scripts/fluent-bit.repo /etc/yum.repos.d/

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

RUN dnf update -y \
  && curl -v -L -O https://dev.mysql.com/get/mysql84-community-release-el9-1.noarch.rpm \
  && dnf install mysql84-community-release-el9-1.noarch.rpm -y \
  && dnf install unzip epel-release mysql-community-client -y \
  && dnf install mono-complete -y \
  && dnf install fluent-bit --nobest -y \
  && dnf -y clean all \
  && rm -rf /var/cache

# Installing saxon he
RUN mkdir saxon \
  && curl -s https://api.github.com/repos/Saxonica/Saxon-HE/releases/latest | grep browser_download_url | cut -d '"' -f 4 >> saxon/file.txt \
  && xargs -n 1 curl --create-dirs -LO --output-dir saxon < saxon/file.txt \
  && unzip saxon/SaxonHE* -d saxon/ \
  && mkdir -p /opt/saxon/lib/ \
  && find saxon/ -name "*jar*" ! -name "*test*" ! -name "*xqj*" -exec cp {} /opt/saxon/lib/ \; 

# Installing aws cli.
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install

# Installing marcedit7.
RUN curl -o /opt/marcedit.run https://marcedit.reeset.net/software/marcedit7/marcedit7.run \
  && chmod u+x /opt/marcedit.run \
  && /opt/marcedit.run --target /opt/marcedit \
  && chmod -R 755 /opt/marcedit

# Copy fluent-bit configuration.
COPY /scripts/fluent-bit.conf /etc/fluent-bit/

# Cleanup.
RUN rm /opt/marcedit.run \
  && rm -rf saxon/ \
  && rm awscliv2.zip

USER gamft

ENTRYPOINT [ "/temp/init.sh" ]