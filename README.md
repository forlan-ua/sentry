Sentry service
==============

## Mac/Linux
1) Run script
```bash
./run.sh
```

2) Run services
```bash
docker-compose up -d
```

## Windows


1) Create folders for data
```batch
mkdir data\postgres && mkdir data\redis && mkdir data\sentry
```

2) Copy template to docker-compose file
```batch
copy docker-compose.yml.tpl docker-compose.yml
```

3) Generate secret key and set SENTRY_SECRET_KEY environment variable for sentry-base service
```batch
docker-compose run --rm base sentry config generate-secret-key
```

4) If this is a new database, you'll need to run upgrade
```batch
docker-compose run --rm base sentry upgrade
```

5) Run services
```batch
docker-compose up -d
```
