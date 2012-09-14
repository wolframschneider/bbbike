#!/bin/sh
# Copyright (c) 2012 Wolfram Schneider, http://bbbike.org
#
# extract a city for further tests

dir=$(dirname $0)
: ${city=Cusco}

osm=$dir/tmp/${city}
data_osm=$dir/tmp/${city}-data-osm

rm -rf $osm $data_osm
mkdir -p $osm

( cd $osm; ln -s ../../$city.osm.pbf )
world/bin/pbf2osm --gzip $osm/$city.osm.pbf

make -s TIME="" DATA_OSM_DIR=$data_osm OSM_DIR=$dir CITIES="$city" convert

( cd $data_osm/$city; find . ! -name '*.gz' -type f -print0 | xargs -0 md5sum | sort ) > $osm/checksum 

