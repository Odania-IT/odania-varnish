FROM alpine:3.6
MAINTAINER Mike Petersen <mike@odania-it.de>

RUN apk update && apk add --no-cache varnish vim
COPY default.vcl /etc/varnish/default.vcl
COPY varnish-secret /varnish-secret
CMD ["varnishd", "-j", "unix,user=varnish", "-F", "-a", "0.0.0.0:80", "-f", "/etc/varnish/default.vcl", "-S", "/varnish-secret", "-T", ":9876"]
