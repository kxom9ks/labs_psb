#!/bin/bash
############################################################
# First version of script for automatization (.sh) for ssh #
#                                                          #
############################################################

HostName="$1"

if [[ $HostName != "" ]]; then

    hostnamectl hostname $HostName > /dev/null

    if [[ $(lastlog) != *"ssh_$HostName"* ]]; then

        /sbin/useradd "ssh_$HostName" -m -G users,sudo -s /bin/bash
        passwd "ssh_$HostName"
        mkdir /home/ssh_$HostName/.ssh
        chown ssh_$HostName:ssh_$HostName /home/ssh_$HostName/.ssh
        chmod 700 /home/ssh_$HostName/.ssh

    else

       echo "Такой пользователь уже есть (ssh_$HostName)"

    fi

    if [[ $HostName = *"Server"* && $(ls -l /home/ssh_$HostName/.ssh 2> /dev/null) != *"id_rsa"* ]]; then

        ssh-keygen -t rsa -b 4096 -f /home/ssh_$HostName/.ssh/id_rsa
        chown ssh_$HostName:ssh_$HostName /home/ssh_$HostName/.ssh/id_rsa
        chown ssh_$HostName:ssh_$HostName /home/ssh_$HostName/.ssh/id_rsa.pub
	    chmod 600 /home/ssh_$HostName/.ssh/id_rsa
	    chmod 600 /home/ssh_$HostName/.ssh/id_rsa.pub
        echo "Пара ключей сгенерирована"

    fi

    if [[ $HostName = *"Server"* && $(ls -l /home/ssh_$HostName/.ssh 2> /dev/null) == *"id_rsa"* ]]; then
        for (( i = 2; i <= $#; i++))
        do
            ssh-copy-id -i /home/ssh_$HostName/.ssh/id_rsa.pub ${!i}
            echo "Ключ передан хосту ${!i}"
        done
    fi

else
    echo "Введите имя пользователя"
fi
