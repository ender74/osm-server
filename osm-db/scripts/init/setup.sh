#!/bin/bash
. ../db.env
export PGPASSWORD=$PGADMINPW

psql -h $PGHOST -d postgres -U $PGADMIN -p $PGPORT -a -w -f prepare_system.sql
psql -h $PGHOST -d gis -U $PGADMIN -p $PGPORT -a -w -f prepare_database.sql
