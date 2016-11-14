#!/bin/bash
SUFFIX="-latest.osm.bz2"

mkdir -p $DATA_DIR

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

echo "fetching osm data ..."

for f in $OSM_REGIONS
do
  FILE_NAME="${f}${SUFFIX}"
  FILE_NAME_ABS="${DATA_DIR}${FILE_NAME}"
  FILE_URL="${OSM_BASE_URL}${FILE_NAME}"
  if [[ "$(curl $FILE_URL -z $FILE_NAME_ABS -o $FILE_NAME_ABS -v -s -L -w %{http_code})" == "200" ]]; then
    TIMESTAMP=$(bunzip2 -k -c $FILE_NAME_ABS | head | sed -n 's/.*osm.*timestamp="\([^"]*\).*/\1/p')
    echo "updated $FILE_NAME. Timestamp: $TIMESTAMP"

    #prepare osmosis update
    UPDATE_DIR="${DATA_DIR}${f}"
    UPDATE_URL="${OSM_BASE_URL}${f}-updates/"

    if [ -d $UPDATE_DIR ]; then
      rm -rf $UPDATE_DIR
    fi

    mkdir -p $UPDATE_DIR
    echo "baseUrl=${UPDATE_URL}" > $UPDATE_DIR/configuration.txt
    echo "maxInterval = 3600" >> $UPDATE_DIR/configuration.txt
    #echo "timestamp=$TIMESTAMP" > $UPDATE_DIR/state.txt

    curl ${UPDATE_URL}/state.txt -o $UPDATE_DIR/state.txt

    ln -s $SCRIPTPATH/../update/load_next.sh $UPDATE_DIR/load_next.sh

    #import new dump
    ./filldb.sh $FILE_NAME_ABS
else
    echo "no newer data found ($?)"
  fi
done
