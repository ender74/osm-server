#!/bin/bash
export PGPASSWORD=$PGUSERPW
FILE_NAME=$1
osm2pgsql --host $PGHOST --port $PGPORT --create --database gis --username $PGUSER --prefix planet_osm --slim --cache 2048 --hstore $FILE_NAME
