#!/bin/bash

DIR=$(dirname $0)
. $DIR/mkimg.cfg

function usage
{
  RC=$1
  echo "Usage: $0 <PLATFORM> <DEVICE>"
  echo "   <PLATFORM> - trunk, backfire"
  echo "   <DEVICE>   - tl-wr1043nd"
  exit $RC
}

PLATFORM=$1
if [ -z "$PLATFORM" ]
then
  usage 1
fi

DEVICE=$2
if [ -z "$DEVICE" ]
then
  usage 2
fi

case $DEVICE in
  tl-wr1043nd)
    ;;
  *)
    echo "Unknown device $DEVICE"
    exit 3
    ;;
esac

case $PLATFORM in
  trunk)
    URL=svn://svn.openwrt.org/openwrt/trunk
    FILES=https://github.com/mrumpf/openwrt-packages/tree/master/openwrt/$DEVICE
    ;;
  backfire)
    URL=svn://svn.openwrt.org/openwrt/branches/backfire
    FILES=https://github.com/mrumpf/openwrt-packages/tree/master/t-10.3/$DEVICE
    ;;
  *)
    echo "Unknown platform $PLATFORM"
    exit 4
    ;;
esac

echo "### Please enter the following parameters:"
if [ -z "$GW" ]
then
  echo "> Gateway server: "
  read -p "GW   = " GW
fi
if [ -z "$MAC" ]
then
  echo "> MAC address: "
  read -p "MAC  = " MAC
fi
if [ -z "$IP" ]
then
  echo "> LAN IP address: "
  read -p "IP   = " IP
fi

if [ -z "$KEY" ]
then
  echo "> WLAN key: "
  read -p "KEY  = " KEY
fi

if [ -z "$SSID" ]
then
  echo "> WLAN SSID: "
  read -p "SSID = " SSID
fi

if [ -z "$DNS" ]
then
  echo "> DNS server: "
  read -p "DNS  = " DNS
fi

if [ -z "$HOST" ]
then
  echo "> HOST name: "
  read -p "HOST = " HOST
fi

echo "# GW   = $GW"
echo "# MAC  = $MAC"
echo "# IP   = $IP"
echo "# KEY  = $KEY"
echo "# SSID = $SSID"
echo "# DNS  = $DNS"
echo "# HOST = $HOST"

read -p "Press ENTER to continue!"

if [ -z "$GW" -o -z "$MAC" -o -z "$IP" -o -z "$KEY" -o -z "$SSID" -o -z "$DNS" -o -z "$HOST" ]
then
  echo "Some of the parameters does not have a value!"
  exit 5
fi

svn co $URL openwrt
cd openwrt

#svn export --force $FILES/ .
git clone $FILES

./scripts/feeds update
./scripts/feeds install -a

#CONFIG_UCI_PRECONFIG_network_lan_dns="@DNS@"
#CONFIG_UCI_PRECONFIG_network_lan_gateway="@GW@"
#CONFIG_UCI_PRECONFIG_network_lan_ipaddr="@IP@"
sed -e "s/@DNS@/$DNS/g" -e "s/@GW@/$GW/g" -e "s/@IP@/$IP/g" config.in > .config
rm -f config.in

#files/etc/config/wireless:4:	option macaddr	@MAC@
#files/etc/config/wireless:14:	option ssid     @SSID@
#files/etc/config/wireless:16:	option key	@KEY@
sed -e "s/@MAC@/$MAC/g" -e "s/@SSID@/$SSID/g" -e "s/@KEY@/$KEY/g" files/etc/config/wireless.in > files/etc/config/wireless
rm -f files/etc/config/wireless.in
cat files/etc/config/wireless

#files/etc/config/network:12:	option 'gateway' '@GW@'
#files/etc/config/network:13:	option 'ipaddr' '@IP@'
sed -e "s/@GW@/$GW/g" -e "s/@IP@/$IP/g" -e "s/@DNS@/$DNS/g" files/etc/config/network.in > files/etc/config/network
cat files/etc/config/network
rm -f files/etc/config/network.in

#files/etc/config/system:3:   option 'hostname' '@HOST@'
sed -e "s/@HOST@/$HOST/g" files/etc/config/system.in > files/etc/config/system
cat files/etc/config/system
rm -f files/etc/config/system.in

#files/etc/resolv.conf.in:3:nameserver @DNS@
sed -e "s/@DNS@/$DNS/g" files/etc/resolv.conf.in > files/etc/resolv.conf
cat files/etc/resolv.conf
rm -f files/etc/resolv.conf.in

time make -j 5

ls -la $(pwd)/bin/ar71xx/openwrt-ar71xx-tl-wr1043nd-v1-squashfs-sysupgrade.bin


