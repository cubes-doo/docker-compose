#!/bin/bash

cd $(dirname "$0")

set -e errexit
set -o pipefail
set -a
. ".env"
set +a

docker-compose up -d

URL="http://localhost:$EXTERNAL_PORT";
echo "Serving at $URL";

if [ ! -z "$START_AUTO_OPEN" ] && [ $START_AUTO_OPEN == 1 ]; then
	which xdg-open 1>/dev/null;
	XDG_OPEN_EXISTS=$?;

	if [ $XDG_OPEN_EXISTS == 0 ]; then
		xdg-open $URL & 
	fi
fi
