#!/bin/sh

echo creating / cpdating certificates at $(date --utc)
certbot certonly -t -n --agree-tos --renew-by-default --email "james.xps@outlook.com" --webroot -w /var/www/steamheadsz.com/ -d "steamheadsz.com" -d "www.steamheadsz.com"
echo "certificates updated"

echo "activating nginx config"    
rm -f /etc/nginx/conf.d/default.conf
ln -s /etc/nginx/steamheadsz.conf /etc/nginx/conf.d/default.conf
echo "nginx configured"