FROM centos:7
RUN yum install -y krb5-workstation
COPY . /sandbox
RUN /sandbox/kerberize.sh
COPY ./vsql /usr/local/bin/vsql
ENTRYPOINT ["/bin/bash"]

