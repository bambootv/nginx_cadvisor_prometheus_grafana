FROM nginx:1.27

RUN set -e; \
    apt-get update; \
    apt-get install -y --no-install-recommends cron logrotate; \
    rm -rf /var/lib/apt/lists/*

COPY nginx/logrotate.conf /etc/logrotate.d/nginx
COPY nginx/crontab /etc/cron.d/logrotate
COPY nginx/entrypoint.sh /docker-entrypoint.d/10-nginx-logrotate.sh

RUN chmod 0644 /etc/cron.d/logrotate && \
    chmod +x /docker-entrypoint.d/10-nginx-logrotate.sh
