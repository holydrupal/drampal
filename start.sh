#!/bin/bash
echo "<============ Starting up Drampal ============>";
if [ ! -f /mysql-configured ]; then
  if [[ -f /var/www/index.html ]]; then
     rm -f /var/www/index.html;
  fi
  /usr/bin/mysqld_safe &
  sleep 10s
  MYSQL_PASSWORD=`pwgen -c -n -1 12`
  echo MySQL password: ${MYSQL_PASSWORD};
  echo "MySQL password: ${MYSQL_PASSWORD}" > /pw.txt;
  mysqladmin -u root password ${MYSQL_PASSWORD};
  touch /mysql-configured;
  DRUPAL_PASSWORD=`pwgen -c -n -1 12`
  echo Drupal password: ${DRUPAL_PASSWORD};
  echo "Drupal password: ${DRUPAL_PASSWORD}" >> /pw.txt;
  service apache2 start;

  source /drupal.sh ${MYSQL_PASSWORD} ${DRUPAL_PASSWORD};

  killall apache2;
  killall mysqld;
  sleep 10s

fi

supervisord -n

