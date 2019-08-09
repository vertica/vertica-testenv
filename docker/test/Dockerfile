FROM python:3.7-alpine

COPY . /vp
WORKDIR /vp
RUN apk add build-base krb5-dev
RUN pip install kerberos pytz python-dateutil tox
RUN /bin/cp -f docker/test/tox.ini tox.ini
ENTRYPOINT ["/bin/bash"]

