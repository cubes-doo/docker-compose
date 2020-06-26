#!/bin/bash
cd $(dirname "$0")
SCRIPT_ARG=$1;
BACKUP_PATH=$2;

set -e errexit;

. ".env";


backup=../${MYSQL_BACKUP_FOLDER}/backup-$(date "+%b_%d_%Y_%H_%M_%S").sql;

MAKE_BACKUP=1;
REMIGRATE=1;
IMPORT_BACKUP=1;

if [ -z "$SCRIPT_ARG" ]; then
:
else
    echo $SCRIPT_ARG;
    if [ "$SCRIPT_ARG" = "just-backup" ]; then
        REMIGRATE=0;
	    IMPORT_BACKUP=0;
    fi
    if [ "$SCRIPT_ARG" = "import-backup" ]; then
        if [ -z "$BACKUP_PATH" ]; then
            echo "Second argument is required (name of the backup file)!";
            exit 1;
        fi
        MAKE_BACKUP=0;
        REMIGRATE=0;
        backup="../$BACKUP_PATH";
    fi
fi

if [ $MAKE_BACKUP -eq 1 ]; then
    echo "creating $backup ...";
    docker exec -i -u root ${COMPOSE_PROJECT_NAME}_db mysqldump --no-create-info -u root --password=$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE --ignore-table=$MYSQL_DATABASE.migrations --ignore-table=$MYSQL_DATABASE.seeds > $backup;
fi

if [ $REMIGRATE -eq 1 ]; then
    echo "remigrating tables ...";
    docker exec -u localuser -t ${COMPOSE_PROJECT_NAME}_${COMPOSE_PHP_MODULE} php artisan migrate:fresh;
fi

if [ $IMPORT_BACKUP -eq 1 ]; then
    echo "importing $backup ...";
    docker exec -i -u root ${COMPOSE_PROJECT_NAME}_db mysql -u root --password=$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < $backup;
fi

echo "done";
