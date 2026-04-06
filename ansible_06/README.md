#
# $template PostgreSQL, "INSERT INTO logs_table (Hostname, Facility, Priority, Severity, Message, Timestamp) VALUES ('%HOSTNAME%', '%syslogfacility%', '%syslogpriority%', '%syslogseverity%', '%msg%', '%timestamp:::date-rfc3339%')",sql 
# *.*;auth,authpriv.none action(type="ompgsql" server="!" serverport="!" db="!" user="!" pwd="!" template="PostgreSQL")
# /etc/rsyslog.conf for DB 
# DB on homelab server (connect DBeaver on pgsql)
# sudo check ["GET /?hello=this_test HTTP/1.1" 200 -] x2
