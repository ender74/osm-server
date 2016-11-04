#!/bin/bash
export PGPASSWORD=$PGADMINPW
DATA_DIR=../../data

if psql -h $PGHOST -d postgres -U $PGADMIN -p $PGPORT -lqt | cut -d \| -f 1 | grep -qw gis; then
    echo "database exists, doing nothing"
else
  echo "removing $DATA_DIR"
  rm -rf $DATA_DIR

  ./setup.sh
  ./refreshData.sh
fi
