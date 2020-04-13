#! /bin/bash

set -e

# start services
service postgresql start
if [ -z $DISABLE_ORCA ]; then
  service rabbitmq-server start
  service jma-receipt start
  service supervisor start # for orca pusher
fi

# set ormaster password
sudo -u orca psql orca -c "DELETE FROM tbl_passwd WHERE userid = 'ormaster';"
NPASS=`md5pass $ORMASTER_PASSWORD`
sudo -u orca psql orca -c "INSERT INTO tbl_passwd (userid, password) VALUES ('ormaster', '${NPASS}');"

exec "$@"
