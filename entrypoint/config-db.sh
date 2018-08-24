#!/bin/bash

sudo su  mv -f /setup/postgresql.conf $PGDATA/postgresql.conf
sudo su chown -R postgres.postgres $PGDATA/postgresql.conf

/etc/init.d/postgresql restart
pg_createcluster -e LATIN1 9.5 main
