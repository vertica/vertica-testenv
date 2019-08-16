#! /bin/sh
KDC=$KDC_ADDR
REALM=EXAMPLE.COM

# Set up Kerberos.
# The 5-second expiration time is because we cannot change system time to expire a ticket.
echo "[logging]
 default = FILE:/var/log/krb5libs.log
 kdc = FILE:/var/log/krb5kdc.log
 admin_server = FILE:/var/log/kadmind.log
[libdefaults]
 default_realm = $REALM
 dns_lookup_realm = false
 dns_lookup_kdc = false
 ticket_lifetime = 5s
 renew_lifetime = 7d
 forwardable = true
[realms]
 $REALM = {
  kdc = $KDC
  admin_server = $KDC
 }
 [domain_realm]
 .example.com = $REALM
 example.com = $REALM" | tee /etc/krb5.conf

# Set up tox config
echo "
[vp_test_config]

# Connection information
VP_TEST_HOST=$DB_ADDR
VP_TEST_PORT=5433
VP_TEST_USER=dbadmin
VP_TEST_ENABLE_KERBEROS_TEST=True

# Logging information
VP_TEST_LOG_LEVEL=INFO
VP_TEST_LOG_DIR=mylog/vp_tox_tests_log
" | tee ./vertica_python/tests/common/vp_test.conf

echo -e "\n    kerberos" | tee -a tox.ini