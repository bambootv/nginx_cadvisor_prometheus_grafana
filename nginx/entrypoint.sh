#!/bin/sh
set -e

# Ensure log files exist and are regular files (logrotate needs this)
for file in access.log error.log; do
    log_path="/var/log/nginx/${file}"
    if [ -L "${log_path}" ]; then
        unlink "${log_path}"
    fi
    touch "${log_path}"
    chmod 644 "${log_path}"
done

touch /var/log/cron.log
chmod 644 /var/log/cron.log

# Wire up logrotate cronjob if provided via bind mount
if [ -f /etc/cron.d/logrotate ]; then
    crontab /etc/cron.d/logrotate
    cron
fi
