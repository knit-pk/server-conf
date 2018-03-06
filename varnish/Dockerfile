FROM alpine:3.7

RUN apk update && apk upgrade && \
    apk add --no-cache varnish

COPY default.vcl /etc/varnish/
COPY docker-app-startup.sh /usr/local/bin/docker-app-startup
RUN chmod +x /usr/local/bin/docker-app-startup

CMD ["docker-app-startup"]