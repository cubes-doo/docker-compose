#!/bin/bash

cd $(dirname "$0")

set -o pipefail
set -a
. ".env"
set +a

docker-compose up -d

if [ $? -ne 0 ]; then
	echo "docker-start.sh: docker-compose error!" 1>&2;
	exit 1;
fi

# print host:server address where this docker container is listening
ipaddr=`ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}'`;
LOCAL_URL="http://localhost:$EXTERNAL_PORT";
EXTERNAL_URL="http://$ipaddr:$EXTERNAL_PORT";
echo -e -n "Serving local at  \033[1;36m${LOCAL_URL}\n\033[0m";
echo -e -n "Serving external at \033[1;35m${EXTERNAL_URL}\n\033[0m";

# create QR code and print it if 'qrencode' program exists
which qrencode &>/dev/null;

if [ $? -eq 0 ]; then
	echo "QR code:";
	qrencode -m 2 -t utf8 <<< $EXTERNAL_URL;
fi

# Try to open new tab in the browser
if [ ! -z "$START_AUTO_OPEN" ] && [ $START_AUTO_OPEN == 1 ]; then
	which xdg-open 1>/dev/null;
	XDG_OPEN_EXISTS=$?;

	if [ $XDG_OPEN_EXISTS == 0 ]; then
		xdg-open $LOCAL_URL &>/dev/null & 
	fi
fi

exit 0;
