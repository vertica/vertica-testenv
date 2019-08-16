FROM python:<ver>-alpine
ARG KDC_ADDR
ARG DB_ADDR

RUN apk add build-base krb5 krb5-dev
RUN pip install kerberos pytz python-dateutil tox
COPY . /vp
WORKDIR /vp
RUN ./vertica-testenv/docker/test/kerberize.sh
ENTRYPOINT ["tox"]
# ENTRYPOINT ["/bin/sh"]