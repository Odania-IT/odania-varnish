#!/usr/bin/env bash
cd /srv/odania

echo "Generating varnish config"
pwd
ls -lha
bundle install
rake varnish:generate

echo "Starting varnish on port ${LISTEN_PORT} with config file ${VCL_CONFIG}"
exec varnishd -j unix,user=varnish -F -a 0.0.0.0:$LISTEN_PORT -f $VCL_CONFIG
