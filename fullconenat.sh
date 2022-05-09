#!/bin/bash

set -x
sleep 5

TUN_NETDEV=warpspeed
EXT_NETDEV=enp1s0

IP_NAT_RULES=`iptables-save -t nat |grep -Ee "(-i|-o) ($EXT_NETDEV|$TUN_NETDEV) -j FULLCONENAT"`
echo "$IP_NAT_RULES" | sed "s#-A#-D#" | xargs -r -L1 iptables -t nat

iptables -t nat -I POSTROUTING -o $EXT_NETDEV -j FULLCONENAT
iptables -t nat -I PREROUTING -i $EXT_NETDEV -j FULLCONENAT
iptables -t nat -I PREROUTING -i $TUN_NETDEV -j FULLCONENAT
