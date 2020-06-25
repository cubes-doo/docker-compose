#!/bin/bash

cd $(dirname "$0")

set -e errexit
set -o pipefail
set -a
. ".env"
set +a

docker-compose up -d

# print host:server address where this docker container is listening
URL="http://localhost:$EXTERNAL_PORT";
echo -e -n "Serving at \033[1;36m${URL}\n\033[0m";

# Try to open new tab in the browser
if [ ! -z "$START_AUTO_OPEN" ] && [ $START_AUTO_OPEN == 1 ]; then
	which xdg-open 1>/dev/null;
	XDG_OPEN_EXISTS=$?;

	if [ $XDG_OPEN_EXISTS == 0 ]; then
		xdg-open $URL &>/dev/null & 
	fi
fi
