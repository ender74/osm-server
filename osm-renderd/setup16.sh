#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git autoconf libtool libmapnik-dev apache2-dev curl unzip gdal-bin mapnik-utils node-carto &&
  sudo apt-get install -y apache2 apache2-utils unifont &&
  sudo apt-get install fonts-dejavu-core fonts-droid-fallback ttf-unifont \
    fonts-sipa-arundina fonts-sil-padauk fonts-khmeros \
    fonts-beng-extra fonts-gargi fonts-taml-tscu fonts-tibetan-machine
git clone https://github.com/openstreetmap/mod_tile.git
cd mod_tile
./autogen.sh
./configure --prefix=/usr
make -j`nproc` && sudo make install && sudo make install-mod_tile
sudo cp /opt/src/mod_tile/debian/renderd.init /etc/init.d/renderd
sudo chmod +x /etc/init.d/renderd
cd ..

wget https://github.com/gravitystorm/openstreetmap-carto/archive/v2.41.0.tar.gz
tar xvf v2.41.0.tar.gz
cd openstreetmap-carto-2.41.0
./get-shapefiles.sh
carto project.mml > style.xml
