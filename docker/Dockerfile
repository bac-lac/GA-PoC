ARG BASE_IMAGE=fortrallc/goanywhere-mft:7.9.1

FROM $BASE_IMAGE AS builder

FROM $BASE_IMAGE
USER root
WORKDIR /temp
COPY --from=builder /opt/Fortra/GoAnywhere/userdata/ userdata/
COPY --from=builder /opt/Fortra/GoAnywhere/upgrader/ upgrader/ 
COPY --from=builder /etc/Fortra/GoAnywhere/config/ config/
COPY --from=builder /etc/Fortra/GoAnywhere/tomcat/ tomcat/
COPY --from=builder /opt/Fortra/GoAnywhere/tomcat/logs/ logs/
COPY --from=builder /opt/Fortra/GoAnywhere/ghttpsroot/custom/ custom/
COPY --from=builder /usr/bin/entrypoint.sh /temp/

COPY /docker/mysql_dump.sql /temp/mysql_dump.sql

COPY /docker/scripts/setenv.sh /opt/Fortra/GoAnywhere/tomcat/bin/

COPY /docker/scripts/init.sh /temp/
RUN chmod -R 777 /temp/

RUN mkdir /etc/Fortra/GoAnywhere/sharedconfig
RUN chown gamft:gamft /etc/Fortra/GoAnywhere/sharedconfig

COPY /docker/configs/*.repo /etc/yum.repos.d/

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

RUN dnf update -y \
  && curl -v -L -O https://dev.mysql.com/get/mysql84-community-release-el9-1.noarch.rpm \
  && dnf install mysql84-community-release-el9-1.noarch.rpm -y \
  && dnf install unzip epel-release mysql-community-client -y \
  && dnf install mono-complete -y \
  && dnf install fluent-bit --nobest -y \
  && dnf -y clean all \
  && rm -rf /var/cache

# Installing latest SaxonC 12 HE
RUN BASE_URL="https://downloads.saxonica.com/SaxonC/HE/12" && \
    FILE=$(curl -s "$BASE_URL/index.html" \
      | grep -o 'SaxonCHE-linux-x86_64-[0-9-]*' \
      | sort -V \
      | tail -1) && \
    curl -L -o /tmp/saxon.zip "$BASE_URL/$FILE.zip" && \
    unzip /tmp/saxon.zip -d /opt/saxonica && \
    rm /tmp/saxon.zip && \
    export LD_LIBRARY_PATH="/opt/saxonica/$FILE/SaxonCCoreHE/lib:/opt/saxonica/$FILE/SaxonCHE/lib:$LD_LIBRARY_PATH" && \
    export PATH="/opt/saxonica/$FILE/SaxonCHE/bin:$PATH"

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
COPY /docker/configs/fluent-bit.conf /etc/fluent-bit/
RUN chmod -R 777 /etc/fluent-bit/

# Cleanup.
RUN rm /opt/marcedit.run \
  && rm -rf saxon/ \
  && rm awscliv2.zip

USER gamft

ENTRYPOINT [ "/temp/init.sh" ]