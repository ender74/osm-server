#!/bin/bash
export PGPASSWORD=$PGUSERPW

echo "waiting for tables ..."
until psql -h $PGHOST -d gis -U $PGUSER -p $PGPORT -c '\dt' | cut -d \| -f 2 | grep -qw planet_osm_polygon; do
  >&2 echo "OSM table not found - sleeping"
  sleep 10
done
