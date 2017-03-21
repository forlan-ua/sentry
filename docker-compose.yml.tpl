version: '2'

services:
    redis:
      image: redis
      volumes:
          - ./data/redis:/data

    postgres:
      image: postgres
      environment:
        - POSTGRES_PASSWORD=sentry
        - POSTGRES_USER=sentry
        - PGDATA=/data
        - POSTGRES_DB=sentry_db
      volumes:
        - ./data/postgres:/data

    base:
      image: sentry
      environment:
        - SENTRY_SECRET_KEY=<SECRET>

        - SENTRY_POSTGRES_HOST=postgres
        - SENTRY_DB_NAME=sentry_db
        - SENTRY_DB_USER=sentry
        - SENTRY_DB_PASSWORD=sentry

        - SENTRY_REDIS_HOST=redis
        - SENTRY_REDIS_PORT=6379

        - SENTRY_FILESTORE_DIR=/data
      volumes:
          - ./data/sentry:/data

    web:
      extends: base
      links:
        - redis
        - postgres
      ports:
        - '9000:9000'

    worker:
      extends: base
      links:
        - redis
        - postgres
      command: sentry run worker

    cron:
      extends: base
      links:
        - redis
        - postgres
      command: sentry run cron
