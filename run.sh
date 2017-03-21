#!/bin/bash

mkdir -p ./data/postgres && mkdir -p ./data/redis && mkdir -p ./data/sentry
cp docker-compose.yml.tpl docker-compose.yml
KEY=$(docker-compose run --rm base sentry config generate-secret-key)
SAFE_KEY=$(echo $KEY | sed -e 's/[\/$*.^|&]/\\&/g')

cp docker-compose.yml.tpl ./data/sentry/docker-compose.yml
cp run.sh ./data/sentry/run.sh

docker-compose run --rm base sed -i "s/<SECRET>/$SAFE_KEY/g" /data/docker-compose.yml

cp ./data/sentry/docker-compose.yml docker-compose.yml
rm ./data/sentry/docker-compose.yml.tpl ./data/sentry/docker-compose.yml ./data/sentry/run.sh

# docker-compose run --rm base sentry upgrade
