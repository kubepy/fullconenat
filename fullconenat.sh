#!/bin/bash

set -x
sleep 5

TUN_NETDEV=warpspeed
EXT_NETDEV=enp1s0

iptables -t nat -I POSTROUTING -o $EXT_NETDEV -j FULLCONENAT
iptables -t nat -I PREROUTING -i $EXT_NETDEV -j FULLCONENAT
iptables -t nat -I PREROUTING -i $TUN_NETDEV -j FULLCONENAT
