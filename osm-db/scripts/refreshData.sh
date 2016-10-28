#!/bin/bash
BASE_URL="http://download.geofabrik.de/europe/germany/"
SUFFIX="-latest.osm.bz2"

mkdir -p ../data

for f in $(<osm-regions.list)
do
  FILE_NAME="${f}${SUFFIX}"
  FILE_URL="${BASE_URL}${FILE_NAME}"
  if [[ "$(curl $FILE_URL -z ../data/$FILE_NAME -o ../data/$FILE_NAME -s -L -w %{http_code})" == "200" ]]; then
    echo "updated ${FILE_NAME}"
    ./filldb.sh $FILE_NAME
  fi
done
