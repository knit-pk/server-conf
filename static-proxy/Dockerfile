ARG KNIT_API_TAG=latest
ARG KNIT_API_ADMIN_TAG=latest
ARG KNIT_HOMEPAGE_TAG=latest

# Prepare static resources
FROM knitpk/api:${KNIT_API_TAG} as api
FROM knitpk/homepage:${KNIT_HOMEPAGE_TAG} as hompepage
FROM knitpk/api-admin:${KNIT_API_ADMIN_TAG} as api-admin


ARG ADMIN_PUBLIC_URL='/admin'
ARG ADMIN_API_URL='http://localhost'
ENV PUBLIC_URL=${ADMIN_PUBLIC_URL} \
    REACT_APP_API_URL=${ADMIN_API_URL}

RUN ASSETS_VERSION=$(cat build/asset-manifest.json | grep "\"main.js\"" | sed -E "s/\s+\"main.js\": \"static\/js\/main\.(.*)\.js\",/\1/") && \
    dockerize -delims "{{{:}}}" \
      -template build/index.html.tmpl:build/index.html \
      -template build/service-worker.js.tmpl:build/service-worker.js \
      -template build/static/js/main.$ASSETS_VERSION.js.tmpl:build/static/js/main.$ASSETS_VERSION.js \
      -template build/static/js/main.$ASSETS_VERSION.js.map.tmpl:build/static/js/main.$ASSETS_VERSION.js.map


# Bundle static proxy image
FROM alpine:3.8

RUN apk add --no-cache nginx

COPY docker-app-start.sh /usr/local/bin/docker-app-start
RUN chmod +x /usr/local/bin/docker-app-start

ENV PORT=80 \
    API_URL=http://api:9501 \
    HOMEPAGE_URL=http://homepage:3000

CMD ["docker-app-start"]

# Copy static proxy configuration and resources
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./sites/* /etc/nginx/conf.d/
COPY ./static /usr/src/proxy/public/

# Add api static resources
COPY --from=api /usr/src/api/public /usr/src/api/public
COPY --from=api-admin /usr/src/app/build /usr/src/api/public/admin

# Add homepage static resources
COPY --from=hompepage /usr/src/app/src/static /usr/src/homepage/public
COPY --from=hompepage /usr/src/app/.nuxt/dist/client /usr/src/homepage/public/_nuxt