# Use the official Nginx base image
FROM nginx:1.27.0

# Install runtime dependencies and clean up in a single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends cron logrotate && \
    rm -rf /var/lib/apt/lists/*

# Copy configuration files
# The official image uses /etc/nginx/nginx.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf
# And includes configs from /etc/nginx/conf.d/
COPY nginx/nginx_sites_available /etc/nginx/conf.d/default.conf
COPY nginx/logrotate.conf /etc/logrotate.d/nginx
COPY nginx/crontab /etc/cron.d/logrotate

# Expose the necessary port
EXPOSE 80

# Copy entry point script
COPY /nginx/entrypoint.sh /entrypoint.sh

# Ensure the script is executable
RUN chmod +x /entrypoint.sh

# Set the entry point
ENTRYPOINT ["/entrypoint.sh"]
