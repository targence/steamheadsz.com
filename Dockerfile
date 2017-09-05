FROM nginx:1.13-alpine

RUN  apk add --no-cache bash certbot openssl \
     && openssl dhparam -out /etc/nginx/dh2048.pem 2048

COPY ["./entrypoint.sh", "/le.sh", "/le.conf", "/"]

RUN chmod +x /entrypoint.sh \
     && chmod +x /le.sh

EXPOSE 80 443
STOPSIGNAL SIGTERM
ENTRYPOINT ["/entrypoint.sh"]
