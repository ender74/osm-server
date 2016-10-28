FROM ubuntu:16.04
MAINTAINER Heiko Hüter <ender@ender74.de>

ENV PGVERSION 9.5
ENV POSTGISVERSION 2.2

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y postgresql-${PGVERSION} postgresql-contrib-${PGVERSION} \
      postgis postgresql-${PGVERSION}-postgis-${POSTGISVERSION} postgresql-${PGVERSION}-pgrouting \
    && apt-get autoremove -y \
        # Clean up
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /root/.cache

ENV PGPATH /usr/lib/postgresql/$PGVERSION/bin
ENV PGDATA /var/lib/postgresql/$PGVERSION/main
ENV PATH $PGPATH:$PATH

RUN cp -v /usr/share/postgresql/$PGVERSION/postgresql.conf.sample $PGDATA/postgresql.conf \
  && echo "local all all          ident" > $PGDATA/pg_hba.conf \
  && echo "host all all 0.0.0.0/0 md5" >> $PGDATA/pg_hba.conf \
  && echo "host all all ::1/128   md5" >> $PGDATA/pg_hba.conf \
	&& sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" $PGDATA/postgresql.conf

USER postgres
RUN bash -c "postgres&" \
    && sleep 10 \
    && psql -U postgres -c "alter user postgres password 'postgres';"

VOLUME $PGDATA
EXPOSE 5432
CMD ["/bin/bash", "-c", "$PGPATH/postgres", "-D $PGDATA"]
