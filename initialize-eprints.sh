#!/bin/bash

if [ ! -f /tmp/eprints_initialized ]; then 
  sudo -u eprints MYSQL_PORT_3306_TCP_ADDR=$MYSQL_PORT_3306_TCP_ADDR MYSQL_PORT_3306_TCP_PORT=$MYSQL_PORT_3306_TCP_PORT MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD expect -f /tmp/initialize-eprints.expect
  
  sudo -u eprints /usr/share/eprints3/bin/generate_static test1

  sudo -u eprints /usr/share/eprints3/bin/import_subjects test1
  sudo -u eprints /usr/share/eprints3/bin/generate_apacheconf
  echo "1" > /tmp/eprints_initialized
fi
