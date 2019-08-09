FROM centos:7
RUN yum install krb5-server krb5-libs krb5-workstation -y
COPY . /kdc
EXPOSE 88
CMD /sbin/init
