FROM ubuntu:16.04
MAINTAINER Heiko Hüter <ender@ender74.de>

ENV PGVERSION 9.5

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y postgresql-client-${PGVERSION} curl osm2pgsql \
    && apt-get autoremove -y \
        # Clean up
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /root/.cache

ADD scripts /opt/scripts

ENTRYPOINT ["/bin/bash", "/opt/scripts/entrypoint.sh"]
CMD ["--help"]
