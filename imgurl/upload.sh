#!/bin/bash

URL=https://www.imgurl.org/api/v2/upload

if [[ -f .private ]]; then
	. .private
fi

FILE=$1

resp=$(curl -X POST -F "uid=$IMG_UID" -F "token=$IMG_TOKEN" -F "file=@$FILE" $URL)

echo $resp
