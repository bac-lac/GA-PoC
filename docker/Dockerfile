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
  && yum install https://centos7.iuscommunity.org/ius-release.rpm \
  && yum install python36u python36u-devel python36u-pip \
  && yum -y clean all \
  && rm -rf /var/cache

USER gamft