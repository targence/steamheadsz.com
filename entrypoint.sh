#!/bin/sh

# Generating pem file take long time, so we moved it to Dockerfile
# it is less secure but faster to start up the app

#if [ ! -f /etc/nginx/dh2048.pem ]; then
#    echo "make dhparams"
#    openssl dhparam -out /etc/nginx/dh2048.pem 2048
#    chmod 600 /etc/nginx/dh2048.pem
#fi

FOLDER="/etc/letsencrypt/live/steamheadsz.com/"
  if [ -e $FOLDER/fullchain.pem ] && [ -e $FOLDER/privkey.pem ] && [ "$LETSENCRYPT" = "true" ]; then
    echo "nginx starting with existing LE certificates"
    echo "activating nginx config"    
    rm -f /etc/nginx/conf.d/default.conf
    ln -s /etc/nginx/steamheadsz.conf /etc/nginx/conf.d/default.conf;
    echo "nginx configured"
  else
    echo "nginx starting without certificates"
    rm -f /etc/nginx/conf.d/default.conf
    ln -s /le.conf /etc/nginx/conf.d/default.conf;    
  fi

if [ "$LETSENCRYPT" = "true" ]; then
  (
  sleep 5 #give nginx time to start
  echo "start letsencrypt updater"
  while :
  do
      echo "trying to update letsencrypt ..."
      /le.sh
      echo "reloading nginx..."
      nginx -s reload
      sleep 25d
  done
  ) &
else
    echo "letsencrypt disabled"
fi


echo "starting nginx..."
nginx -g "daemon off;"


