#!/bin/bash
dia=$(date | awk '{print $2}')
hosts=$(basename -s .key /etc/openvpn/easy-rsa/keys/*.key)
#users=$(tail -40 /var/log/openvpn-status.log |grep "$hosts" | grep 'Connection Initiated' | sed -n '/'$dia'/,/'" $(date | cut -d' ' -f4) "'/p' | wc -l )
address=$(tail -40 /var/log/openvpn-status.log | grep 'virtual IP' | grep -Eo '(...\.){3}.*' )
cont=0
for x in ${address[@]}
do
   ping -c1 -W1 $x &> /dev/null
   if [ $? -eq 0 ] ; then
	 let cont++
	 echo $cont > /tmp/users
   else
	 echo $cont > /tmp/users
   fi
done

