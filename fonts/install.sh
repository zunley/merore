#!/bin/bash

set -ex

path=$(cd `dirname $0`;pwd)
cp -r $path/Hack /usr/share/fonts/

fc-cache -fv
