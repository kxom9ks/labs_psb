#!/bin/bash

sed -i 's/^UMASK[[:space:]]*[0-9]\{3\}/UMASK\t\t027/g' /etc/login.defs
echo "login.defs UMASK 027"

touch /etc/profile.d/orgnm.sh; echo -e "#!/bin/bash\numask 027" > /etc/profile.d/orgnm.sh; chmod +x /etc/profile.d/orgnm.sh
echo "Create orgnm.sh"
source /etc/profile.d/orgnm.sh
echo "Start orgnm.sh"
echo "test" > /etc/profile.d/test.txt
echo "Change profile.d umask=$(cd /etc/profile.d | umask) | test file = $(stat -c '%a' /etc/profile.d/test.txt)"
rm /etc/profile.d/test.txt

sed -i 's/^#\?DIR_MODE=[0-9]\{4\}/DIR_MODE=0700/g' /etc/adduser.conf
echo "DIR_MODE=0700"

find /var/log -type f -exec chmod g-wx,o-rwx "{}" + -o -type d -exec chmod g-w,o-rwx "{}" +
echo "Find g-wx o-rwx in /var/log executed"
