#!/bin/bash

ip_port=$1

sed -i 's/active\s*=.*/active = yes/g' /etc/audit/plugins.d/syslog.conf

if [[ $(grep "@@" /etc/rsyslog.conf) != "" ]]; then

sed -i -E "s/\*.\*\s*@@([0-9]{1,3}[.\]){3}[0-9]{1,3}[\:][0-9]{1,5}/\*.\* @@${1}/g" /etc/rsyslog.conf

else

echo "*.* @@${1}" >> /etc/rsyslog.conf

fi

sed -i 's/name_format\s*=.*/name_format = HOSTNAME/g' /etc/audit/auditd.conf

sed -i 's/log_format\s*=.*/log_format = ENRICHED/g' /etc/audit/auditd.conf


