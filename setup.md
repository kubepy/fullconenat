```
apt install build-essential autoconf libtool bison flex libnftnl-dev libmnl-dev -y
```

```
cd
git clone https://github.com/Chion82/netfilter-full-cone-nat.git
cd netfilter-full-cone-nat/
make
```

```
modprobe nf_nat
insmod xt_FULLCONENAT.ko
lsmod | grep xt_FULLCONENAT
```

```
cp xt_FULLCONENAT.ko /lib/modules/`uname -r`/kernel/net/netfilter/
echo 'kernel/net/netfilter/xt_FULLCONENAT.ko:' >> /lib/modules/`uname -r`/modules.dep
depmod

echo '
nf_nat
xt_FULLCONENAT
' >> /etc/modules-load.d/modules.conf
```

```
lsmod | grep xt_FULLCONENAT
xt_FULLCONENAT         36864  0
```

```
cd
git clone -b v1.8.4 --single-branch git://git.netfilter.org/iptables.git
cp netfilter-full-cone-nat/libipt_FULLCONENAT.c iptables/extensions/
cd iptables
./autogen.sh
./configure
make
make install
```
