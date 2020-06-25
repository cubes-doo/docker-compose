#!/bin/bash

TEST_GROUP=$1;
cd $(dirname "$0")

set -e errexit
set -o pipefail
set -a
. ".env"
set +a

if [ ! -z "$TEST_GROUP" ]; then
	TEST_GROUP="--group=$TEST_GROUP";
fi

docker exec -u localuser ${COMPOSE_PROJECT_NAME}_${COMPOSE_PHP_MODULE} \
    vendor/bin/phpunit tests --testdox $TEST_GROUP
