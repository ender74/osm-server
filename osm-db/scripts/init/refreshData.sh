#!/bin/bash
BASE_URL="http://download.geofabrik.de/europe/germany/"
SUFFIX="-latest.osm.bz2"
DATA_DIR=../../data

mkdir -p $DATA_DIR

for f in $(<../osm-regions.list)
do
  FILE_NAME="${f}${SUFFIX}"
  FILE_URL="${BASE_URL}${FILE_NAME}"
  if [[ "$(curl $FILE_URL -z $DATA_DIR/$FILE_NAME -o $DATA_DIR/$FILE_NAME -s -L -w %{http_code})" == "200" ]]; then
    echo "updated ${FILE_NAME}"
    ./filldb.sh $DATA_DIR/$FILE_NAME
  fi
done
