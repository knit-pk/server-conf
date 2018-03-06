FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY sites /etc/nginx/conf.d/
COPY static /usr/src/proxy/public/

RUN adduser -D -u 1000 www-data

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80