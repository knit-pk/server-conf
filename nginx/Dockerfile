ARG KNIT_API_TAG
ARG KNIT_API_ADMIN_TAG
ARG KNIT_HOMEPAGE_TAG

FROM knitpk/api:${KNIT_API_TAG} as api
FROM knitpk/api-admin:${KNIT_API_ADMIN_TAG} as api-admin
FROM knitpk/homepage:${KNIT_HOMEPAGE_TAG} as hompepage
FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY sites /etc/nginx/conf.d/

RUN adduser -D -u 1000 www-data

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80

COPY static /usr/src/proxy/public/

COPY --from=api /usr/src/api/public /usr/src/api/public
# ----------------------------------------------> api \/
COPY --from=api-admin /usr/src/app/build /usr/src/homepage/public/admin
COPY --from=hompepage /usr/src/app/static /usr/src/homepage/public
COPY --from=hompepage /usr/src/app/.nuxt/dist /usr/src/homepage/public/_nuxt