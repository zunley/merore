#!/bin/bash

set -o errexit
set -o nounset

ROOT_UID=0

config="https://raw.githubusercontent.com/tindy2013/subconverter/master/base/config/ACL4SSR_Online_Full.ini"
curl -G -d "target=clash" -d "url=$1" -d "config=$config" https://clash-sub.merore.com/sub | tee $CLASH_HOME/config.yaml

# append authentication or not
cat>>/etc/clash/config.yaml<<EOF
#authentication:
#  - "$auth_user:$auth_pass"
EOF

exit 0
