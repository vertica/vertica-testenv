FROM python:3.7-alpine

RUN apk add build-base krb5-dev
RUN pip install kerberos pytz python-dateutil tox
COPY . /vp
WORKDIR /vp
RUN /bin/cp -f vertica-testenv/docker/test/tox.ini tox.ini
RUN ./kerberize.sh
COPY vertica-testenv/docker/test/vp_test.conf vertica_python/tests/common/vp_test.conf
ENTRYPOINT ["tox"]