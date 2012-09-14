#!/bin/sh
# Copyright (c) 2012 Wolfram Schneider, http://bbbike.org
#
# extract a city for further tests

dir=$(dirname $0)
: ${city=Cusco}

osm=$dir/${city}
data_osm=$dir/${city}-data-osm

rm -rf $osm
mkdir $osm

( cd $osm; ln -s ../$city.osm.gz )

make -s TIME="" DATA_OSM_DIR=$data_osm OSM_DIR=$dir CITIES="$city" convert

( cd $data_osm/$city; find . ! -name '*.gz' -type f -print0 | xargs -0 md5sum | sort ) > $osm/checksum 

