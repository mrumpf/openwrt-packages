#!/bin/bash -x

function usage ()
{
  echo "Usage $0 <VER> <PKG>"
  exit 2
}

VER=$1
if [ -z "$VER" ]
then
  usage
fi

PKG=$2
if [ -z "$PKG" ]
then
  usage
fi

case $PKG in
  m3player)
    URL=https://github.com/mrumpf/openwrt-packages.git
    ;;
  *)
    echo "Uknown package!"
    exit 1
    ;;
esac


TMPDIR=$(mktemp -d ABCXXX)

cd $TMPDIR

git clone $URL $PKG-$VER
tar cvfz ${PKG}-${VER}.tar.gz ${PKG}-${VER}
md5sum ${PKG}-${VER}.tar.gz > ${PKG}-${VER}.tar.gz.md5
MD5=$(awk '{print $1}' ${PKG}-${VER}.tar.gz.md5)
sed -e "s/PKG_VERSION:=.*/PKG_VERSION:=$VER/g" -e "s/PKG_MD5SUM:=.*/PKG_MD5SUM:=$MD5/g" ../packages/m3player/Makefile > ../packages/m3player/Makefile.new
rm ../packages/m3player/Makefile
mv ../packages/m3player/Makefile.new ../packages/m3player/Makefile

ssh user@host mkdir -p /var/www/repos/openwrt/${PKG}/${VER}
scp ${PKG}-${VER}.tar.gz* user@host:/var/www/repos/openwrt/${PKG}/${VER}

cd ..
rm -rf $TMPDIR

echo $MD5

