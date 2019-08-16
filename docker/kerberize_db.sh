#! bin/sh
KDC=kerberos.example.com
KHOST=vertica.example.com
KSN=vertica
REALM=EXAMPLE.COM
KTAB=/vertica.keytab
DBNAME=docker

echo "[logging]
 default = FILE:/var/log/krb5libs.log
 kdc = FILE:/var/log/krb5kdc.log
 admin_server = FILE:/var/log/kadmind.log
[libdefaults]
 default_realm = $REALM
 dns_lookup_realm = false
 dns_lookup_kdc = false
 ticket_lifetime = 24h
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

/opt/vertica/bin/vsql -U dbadmin -a << eof
ALTER DATABASE $DBNAME SET KerberosHostName = '${KHOST}';
ALTER DATABASE $DBNAME SET KerberosRealm = '${REALM}';
ALTER DATABASE $DBNAME SET KerberosKeytabFile = '${KTAB}';
CREATE USER user1;
CREATE AUTHENTICATION kerberos METHOD 'gss' HOST '0.0.0.0/0';
ALTER AUTHENTICATION kerberos enable;
GRANT AUTHENTICATION kerberos TO user1;
CREATE AUTHENTICATION debug METHOD 'trust' HOST '0.0.0.0/0';
ALTER AUTHENTICATION debug enable;
GRANT AUTHENTICATION debug TO dbadmin;
eof
chown dbadmin /vertica.keytab

echo "Restarting Database to apply Kerbseros settings."
/bin/su - dbadmin -c "/opt/vertica/bin/admintools -t stop_db -d $DBNAME"
/bin/su - dbadmin -c "/opt/vertica/bin/admintools -t start_db -d $DBNAME"

/opt/vertica/bin/vsql -U dbadmin -a -c "SELECT kerberos_config_check();"
