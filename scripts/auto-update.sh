#!/bin/bash

set -e

BASE_DIR=$1

projects=(
merore
notebook
)
date=$(date -Iseconds)

: ${BASE_DIR:?}

update()
{
    pushd $1
    git add .
    git commit -m "Auto Update $date"
    git push
    popd
}

for project in ${projects[@]};
do
    update $BASE_DIR/$project
done
