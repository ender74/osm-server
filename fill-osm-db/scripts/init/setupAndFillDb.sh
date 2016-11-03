#!/bin/bash
export PGPASSWORD=$PGADMINPW

if psql -h $PGHOST -d postgres -U $PGADMIN -p $PGPORT -lqt | cut -d \| -f 1 | grep -qw gis; then
    echo "database exists, doing nothing"
else
  rm -rf ../../data
  ./setup.sh && ./refreshData.sh
fi
