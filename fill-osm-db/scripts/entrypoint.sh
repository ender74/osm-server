#!/bin/bash

function usage()
{
    cat <<__EOF__
Usage: $0

Options:

  --setupdb - creates a new, empty gis database (dropping it, if it already exists)
  --initdb - fills the database with the current osm dump (with osm2psql)
  --checkdb - creates and populates the gis database if it's missing. Does nothing otherwise
  --updatedb - incremental update (using osmosis)

Examples:

    $0 --setupdb
    $0 --initdb
    $0 --checkdb
    $0 --updatedb
__EOF__
}

basePath=$(dirname $0)

$basePath/waitForPostgres.sh

optspec=":vh-:"
while getopts "$optspec" optchar; do
    case "${optchar}" in
        -)
            case "${OPTARG}" in
                setupdb)
                    echo "(re)creating the gis database"
                    cd $basePath/init
                    exec ./setup.sh
                    ;;
                initdb)
                    echo "(re)populating the gis database"
                    cd $basePath/init
                    exec ./refreshData.sh
                    ;;
                checkdb)
                    echo "creating and populating the gis database if needed"
                    cd $basePath/init
                    exec ./setupAndFillDb.sh
                    ;;
                updatedb)
                    echo "updating the gis database"
                    cd $basePath/update
                    exec ./load_next.sh
                    ;;
                help)
                    usage
                    exit 0
                    ;;
                *)
                    echo "Unknown option --${OPTARG}" >&2
                    usage
                    exit 0
                    ;;
            esac;;
        *)
            if [ "$OPTERR" != 1 ] || [ "${optspec:0:1}" = ":" ]; then
                echo "Non-option argument: '-${OPTARG}'" >&2
                usage
                exit 1
            fi
            ;;
    esac
done
