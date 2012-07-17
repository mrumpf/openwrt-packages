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
  m3ddity-player)
    URL=https://github.com/jCoderZ/m3player.git
    ;;
  *)
    echo "Uknown package!"
    exit 1
    ;;
esac


TMPDIR=$(mktemp -d ABCXXX)

cd $TMPDIR

git clone $URL ${PKG}-${VER}
tar cvfj ${PKG}-${VER}-src.tar.bz2 ${PKG}-${VER}
md5sum ${PKG}-${VER}-src.tar.bz2 > ${PKG}-${VER}-src.tar.bz2.md5

ssh user@host  mkdir -p /var/www/repos/openwrt/${PKG}/${VER}
scp ${PKG}-${VER}-src.tar.bz2* user@host:/var/www/repos/openwrt/${PKG}/${VER}

rm -rf $TMPDIR

