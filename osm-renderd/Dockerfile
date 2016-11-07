FROM ubuntu:16.04
MAINTAINER Heiko Hüter <ender@ender74.de>

ENV PGVERSION 9.5

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y git build-essential automake autoconf libtool \
      libmapnik-dev apache2-dev curl unzip gdal-bin mapnik-utils node-carto \
      unifont fonts-dejavu-core fonts-droid-fallback ttf-unifont \
      fonts-sipa-arundina fonts-sil-padauk fonts-khmeros \
      fonts-beng-extra fonts-gargi fonts-taml-tscu fonts-tibetan-machine \
      ca-certificates \
      postgresql-client-${PGVERSION} \
      apache2 apache2-utils \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /root/.cache

RUN git clone https://github.com/openstreetmap/mod_tile.git \
    && cd mod_tile \
    && ./autogen.sh \
    && ./configure --prefix=/usr \
    && make -j`nproc` && make install && make install-mod_tile \
    && cd .. && rm -rf mod_tile

ADD mapnik /opt/mapnik/
ADD renderd.conf /etc/renderd/
ADD apache/conf/osm-tiles.conf /etc/apache2/conf-available
ADD apache/sites/osm-tiles.conf /etc/apache2/sites-available
ADD map.html /var/www/html/
RUN ln -s /etc/apache2/conf-available/osm-tiles.conf /etc/apache2/conf-enabled/osm-tiles.conf \
    && ln -s /etc/apache2/sites-available/osm-tiles.conf /etc/apache2/sites-enabled/osm-tiles.conf \
    && chmod u+x /opt/mapnik/*.sh \
    && rm /etc/apache2/sites-enabled/000-default.conf

VOLUME ["/etc/renderd/", "/var/run/renderd/", "/opt/mapnik/", "/var/lib/mod_tile/"]
WORKDIR /opt/mapnik/
CMD ["/bin/bash", "/opt/mapnik/entrypoint.sh"]
