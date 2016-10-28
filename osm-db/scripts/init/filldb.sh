#!/bin/bash
#wget http://download.geofabrik.de/europe/germany/thueringen-latest.osm.bz2
#wget http://download.geofabrik.de/europe/germany/thueringen-updates/
. ../db.env
export PGPASSWORD=$PGUSERPW
FILE_NAME=$1
osm2pgsql --host $PGHOST --port $PGPORT --create --database gis --username $PGUSER --prefix planet --slim --cache 2048 --hstore $FILE_NAME
