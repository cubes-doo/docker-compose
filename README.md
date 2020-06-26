# docker-compose
Docker compose build files for PHP/mysql projects.  
Docker compose helper scripts for much better developer experience and productivity.

## Docker compose build files:
docker-compose.yml  
Dockerfile.phpfpm  
nginx.conf  
php.ini  
phpfpm.conf  
.bashrc  

## Docker compose scripts:

#### ./docker-start.sh  
Start docker container. Build it if it doesn't exist.

- For QR code functionality you must install 'qrencode'  
Linux: ```apt install qrencode```  
Mac: http://macappstore.org/qrencode/
<br/>
- For 'auto open in browser' set START\_AUTO\_OPEN=1 in your .env file.  
Your target browser will the one as returned by running -> ```xdg-settings get default-web-browser```  
To set another target browser e.g. -> ```xdg-settings set default-web-browser google-chrome.desktop```   

#### ./docker-stop.sh
Stop docker container.

#### ./docker-restart.sh
Restart docker container.

#### ./docker-console.sh
Bind host terminal to container's terminal.

#### ./docker-usermod.sh
Sync host user/group with docker container user/group

#### ./docker-destroy.sh
Remove docker container 

#### ./docker-rebuild.sh
Rebuild docker container 

#### ./docker-unit-test-run.sh
Run PHPunit tests

#### ./docker-remigrate-persist.sh
Create backup, remigrate, import from backup...  
MYSQL_BACKUP_FOLDER must be set in .env  
<br/>
Usage:  
- make backup ->  ```./docker-remigrate-persist.sh just-backup```  
- restore from backup ->  ```./docker-remigrate-persist.sh import-backup my/backup/path```

#### ./docker-php-cs-check.sh
Check for PHP code consistency

#### ./docker-php-cs-check.sh
Fix PHP code inconsistencies
