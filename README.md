```
## How to deploy this web site

git clone https://github.com/targence/steamheadsz.com git
cd git
docker build --tag=nginx-le .


rsync -avzh --delete --progress ./public/ username@steamheadsz.com:~/steamheadsz.com/public


docker network create hk

docker run -d --restart=always -p 80:80 -p 443:443 --network=hk -e LETSENCRYPT=true -v="$(pwd)/steamheadsz.conf:/etc/nginx/steamheadsz.conf" -v="$(pwd)/le.conf:/etc/nginx/le.conf" -v="$(pwd)/public:/var/www/steamheadsz.com" -v="$(pwd)/le:/etc/letsencrypt" --name=nginx-le nginx-le
