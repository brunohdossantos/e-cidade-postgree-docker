#!/bin/bash

pg_dropcluster --stop 9.5 main

pg_createcluster -u postgres -g postgres -e LATIN1 --locale="pt_BR.ISO-8859-1" --lc-collate="pt_BR.ISO-8859-1" 9.5 ecidade

cp /setup/postgresql.conf $PGDATA/postgresql.conf
chown -R postgres.postgres $PGDATA/postgresql.conf

/etc/init.d/postgresql restart
#pg_createcluster -e LATIN1 9.5 main
