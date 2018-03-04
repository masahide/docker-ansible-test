FROM centos:6
LABEL maintainer="YAMASAKI Masahide"

RUN yum makecache fast \
 && yum -y install epel-release \
 && yum -y --disablerepo=* --enablerepo=epel update \
 && yum -y --enablerepo=epel install ansible sudo awscli\
 && yum clean all

RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

