ARG KNIT_API_TAG=latest
ARG KNIT_API_ADMIN_TAG=latest
ARG KNIT_HOMEPAGE_TAG=latest

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


FROM alpine:3.8

COPY docker-app-start.sh /usr/local/bin/docker-app-start
RUN apk add --no-cache nginx && \
    chmod +x /usr/local/bin/docker-app-start

COPY nginx.conf /etc/nginx/nginx.conf
COPY sites/* /etc/nginx/conf.d/

COPY static /usr/src/proxy/public/

COPY --from=api /usr/src/api/public /usr/src/api/public
COPY --from=api-admin /usr/src/app/build /usr/src/api/public/admin
COPY --from=hompepage /usr/src/app/static /usr/src/homepage/public 

# TODO: /usr/src/app/.nuxt/dist -> /usr/src/app/.nuxt/dist/client
COPY --from=hompepage /usr/src/app/.nuxt/dist /usr/src/homepage/public/_nuxt

ENV PORT=80
ENV API_URL=http://api
CMD ["docker-app-start"]
