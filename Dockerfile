FROM nginx:1.27.0

# Install only the runtime packages we actually need
RUN apt-get update && \
    apt-get install -y --no-install-recommends cron logrotate && \
    rm -rf /var/lib/apt/lists/*

# Remove the default server snippet to avoid duplicate listens
RUN rm -f /etc/nginx/conf.d/default.conf

# Copy configuration and housekeeping files
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/nginx_sites_available /etc/nginx/conf.d/default.conf
COPY nginx/logrotate.conf /etc/logrotate.d/nginx
COPY nginx/crontab /etc/cron.d/logrotate

# Copy entry point script
COPY nginx/entrypoint.sh /entrypoint.sh

# Ensure the cron definition and entrypoint are usable at runtime
RUN chmod 644 /etc/cron.d/logrotate && \
    chmod +x /entrypoint.sh && \
    touch /var/log/cron.log

# Expose the necessary port
EXPOSE 80

# Set the entry point
ENTRYPOINT ["/entrypoint.sh"]
