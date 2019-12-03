#! /bin/bash

set -e

# start services
service postgresql start
service rabbitmq-server start
service jma-receipt start
service supervisor start # for orca pusher
service push-exchanger start

# set ormaster password
sudo -u orca psql orca -c "DELETE FROM tbl_passwd WHERE userid = 'ormaster';"
NPASS=`md5pass $ORMASTER_PASS`
sudo -u orca psql orca -c "INSERT INTO tbl_passwd (userid, password) VALUES ('ormaster', '${NPASS}');"
sed -i -e "s/^\(:api_user:\s*\).*$/\1ormaster/g" -e "s/^\(:api_key:\s*\).*$/\1${ORMASTER_PASS}/g" /etc/push-exchanger/push-exchanger.yml

exec "$@"
