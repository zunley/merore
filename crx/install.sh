#!/bin/bash

set -e

: ${HOME:?}

CRX_DIR=$HOME/.config/crxs

crxs=(
EverSync
GoogleTranslate
LastPass
Surfingkeys
SwitchyOmega
)

decompress()
{
    echo "unzip $1"
    unzip $1*.crx -d $CRX_DIR/$1
}

mkdir -pv $CRX_DIR

for crx in $crxs
do
    decompress $crx
done
