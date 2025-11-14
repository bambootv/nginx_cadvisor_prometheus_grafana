#!/bin/sh

# Remove symbolic links if they exist
if [ -L /var/log/nginx/access.log ]; then
    unlink /var/log/nginx/access.log
fi

if [ -L /var/log/nginx/error.log ]; then
    unlink /var/log/nginx/error.log
fi

# Ensure log files exist
touch /var/log/nginx/access.log
touch /var/log/nginx/error.log
chmod 644 /var/log/nginx/access.log
chmod 644 /var/log/nginx/error.log

# Start cron
cron  && crontab /etc/cron.d/logrotate

# Start Nginx using the standard path
nginx -g "daemon off;"
