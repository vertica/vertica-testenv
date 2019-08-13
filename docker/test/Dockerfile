FROM python:3.7-alpine

RUN apk add build-base krb5-dev
RUN pip install kerberos pytz python-dateutil tox
COPY . /vp
RUN ./kerberize.sh
WORKDIR /vp
RUN /bin/cp -f vertica-testenv/docker/test/tox.ini tox.ini
ENTRYPOINT ["tox"]