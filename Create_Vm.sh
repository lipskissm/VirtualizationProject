#!/bin/bash

# Instantiate the template
vm_id=$(onetemplate instantiate "2274" --user mali9219 --password "slaptazodis" --endpoint https://grid5.mif.vu.lt/cloud3/RPC2)
mid=$(echo $vm_id | cut -d ' ' -f 3)
echo $mid
sleep 45
echo "Details of machine"
$(onevm show $mid --user mali9219 --password "slaptazodis" --endpoint https://grid5.mif.vu.lt/cloud3/RPC2 > "$mid.txt")
con=$(cat $mid.txt | grep CONNECT_INFO1 | cut -d '=' -f 2 | tr -d '"' | sed 's/^[ \t]*//')
ip=$(cat $mid.txt | grep PRIVATE_IP | cut -d '=' -f 2 | tr -d '"')
echo $con
echo $ip
mpass=$(cat $mid.txt | grep USER\_PASSWD | cut -d '=' -f 2 | tr -d '"' | tr -d ',')
echo $mpass
echo mali9219@$ip


ssh-keygen -t ed25519 -C mali9219$ip
ssh-copy-id -i ~/.ssh/id_ed25519.pub mali9219@$ip
