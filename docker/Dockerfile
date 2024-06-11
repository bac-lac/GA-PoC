FROM helpsystems/goanywhere-mft:latest

USER root

COPY scripts/entrypoint.sh /usr/bin/

# Copy default xml configs.
COPY configs/ /tmp/sharedconfig/ 
RUN chmod -R 777 /tmp/sharedconfig/ 

RUN chmod +x /usr/bin/entrypoint.sh

RUN rm -rf /etc/yum.repos.d/linuxrepos.repo

# Installing dependencies.
RUN yum update -y \
  && yum -y install procps unzip epel-release \
  && yum -y clean all \
  && rm -rf /var/cache

RUN wget https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm \
  && dnf install mysql80-community-release-el9-1.noarch.rpm -y \
  && rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023 \
  && dnf install mysql-community-client -y

USER gamft