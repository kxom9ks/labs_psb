# Сommand ssh with ansible

eval $(ssh-agent -s); ssh-add $PRIVATE_KEY; ansible all,localhost -i "ssh_Client2@192.168.118.2,ssh_Client1@192.168.118.3" -m setup -a "filter=ansible_all_ipv4_addresses,ansible_board_name,ansible_board_vendor,ansible_fqdn,ansible_os_family,ansible_uptime_seconds,ansible_user_id,ansible_bios_vendor" --private-key=$PRIVATE_KEY
