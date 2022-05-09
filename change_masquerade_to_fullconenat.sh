#!/bin/bash

set -x
sleep 5
IP_RANGE="10.99.0.0/16"
IP_NAT_RULES=`iptables-save -t nat |grep -Ee "$IP_RANGE.*-j.*(MASQUERADE|FULLCONENAT)"`
echo "$IP_NAT_RULES" | sed "s#-A#-D#" | xargs -r -L1 iptables -t nat 
echo "$IP_NAT_RULES" | sed "s#MASQUERADE#FULLCONENAT#" | xargs -r -L1 iptables -t nat 
