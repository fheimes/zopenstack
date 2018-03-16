#!/bin/bash -ex
# Add sec groups for basic access
secgroup=${1:-`openstack security group list |grep default| awk '{print $2}'`}

for group in $secgroup; do

    for port in 22 53 80 443; do
        openstack security group rule create $group --protocol tcp --remote-ip 0.0.0.0/0 --dst-port $port ||:
    done

    openstack security group rule create $group --protocol icmp --remote-ip 0.0.0.0/0 ||:
done

