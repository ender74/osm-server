#!/bin/bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y install \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-python-dev libboost-regex-dev \
    libboost-system-dev libboost-thread-dev 
PGVERSION=9.5
sudo apt-get -y install \
    libicu-dev \
    python-dev libxml2 libxml2-dev \
    libfreetype6 libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libproj-dev \
    libtiff-dev \
    libcairo2 libcairo2-dev python-cairo python-cairo-dev \
    libcairomm-1.0-1 libcairomm-1.0-dev \
    ttf-unifont ttf-dejavu ttf-dejavu-core ttf-dejavu-extra \
    git build-essential python-nose \
    libgdal1-dev python-gdal \
    postgresql-server-dev-$PGVERSION \
    libsqlite3-dev

#harfbuzz
rm harfbuzz-0.9.26
wget http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.26.tar.bz2
tar xf harfbuzz-0.9.26.tar.bz2
rm harfbuzz-0.9.26.tar.bz2
cd harfbuzz-0.9.26
./configure && make && sudo make install
sudo ldconfig
cd ../

#mapnik
rm mapnik
#git clone --branch v3.0.12 https://github.com/mapnik/mapnik --depth 10
git clone https://github.com/mapnik/mapnik --depth 10
cd mapnik
git submodule update --init deps/mapbox/variant
./configure CXX=g++-4.8 CC=gcc-4.8
make && sudo make install
cd ..
