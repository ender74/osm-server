#!/bin/bash
export PGPASSWORD=$PGUSERPW
DB_EXISTS=$(psql -h $PGHOST -d postgres -U $PGUSER -p $PGPORT -lqt | cut -d \| -f 1 | grep -qw gis ; echo "$?")
TABLES_EXISTS=$(psql -h $PGHOST -d gis -U $PGUSER -p $PGPORT -c '\dt' | cut -d \| -f 2 | grep -qw planet_osm_polygon ; echo "$?")

echo "DB_EXISTS: $DB_EXISTS"
echo "TABLES_EXISTS: $TABLES_EXISTS"

if [[ "$DB_EXISTS" -eq "0" && "$TABLES_EXISTS" -eq "0" ]]; then
    echo "database exists, doing update"
    /opt/scripts/update/update_all.sh
else
  echo "removing content of $DATA_DIR"
  rm -rf $DATA_DIR/*

  ./setup.sh
  ./refreshData.sh
fi
