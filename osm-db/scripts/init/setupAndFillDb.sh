#!/bin/bash
. ../db.env
export PGPASSWORD=$PGADMINPW

if psql -h $PGHOST -d postgres -U $PGADMIN -p $PGPORT -lqt | cut -d \| -f 1 | grep -qw gis; then
    echo "database exists, doing nothing"
else
  exec ./setup.sh
  exec ./filldb.sh
fi
