FROM odaniait/docker-varnish:latest
MAINTAINER Mike Petersen <mike@odania-it.de>

COPY docker/runit_varnish.sh /etc/service/varnish/run

RUN mkdir -p /srv/odania
COPY . /srv/odania
WORKDIR /srv/odania
RUN bundle install

VOLUME ["/srv/odania"]

ENV OUT_DIR /etc/varnish
