#!/usr/bin/bash

set -o errexit
set -o nounset

E_KNOWNARCH=88
CLASH_HOME=/etc/clash

# prepare environment
rm -rf $CLASH_HOME
mkdir -p $CLASH_HOME

ARCH=amd64
case $(uname -m) in
  x86_64|amd64)
    ARCH=amd64
  ;;
  loongarch64)
    ARCH=loong64
  ;;
  *)
    err "Unknow architecture."
    exit $E_UNKNOWNARCH
  ;;
esac

get_latest_version()
{
    curl -sfL "https://api.github.com/repos/$1/releases/latest" | \
        grep tag_name | head -n 1 | awk -F ": " '{print $2}' | \
        sed 's/\"//g;s/\,//g'
}

# install clash
CLASH_VERSION=$(get_latest_version Dreamacro/clash)
echo ""
echo "Install clash $CLASH_VERSION"
curl -L https://github.com/Dreamacro/clash/releases/download/$CLASH_VERSION/clash-linux-$ARCH-v3-$CLASH_VERSION.gz -o clash.gz
gzip -d clash.gz && chmod +x clash && mv clash $CLASH_HOME/ && ln -sf $CLASH_HOME/clash /usr/bin/clash

# install mmdb
MMDB_VERSION=$(get_latest_version Dreamacro/maxmind-geoip)
echo ""
echo "Install mmdb $MMDB_VERSION"
curl -L https://github.com/Dreamacro/maxmind-geoip/releases/download/$MMDB_VERSION/Country.mmdb -o $CLASH_HOME/Country.mmdb

# install service
cp clash.service /etc/systemd/system/

echo ""
echo "Install Completely!"

exit 0
