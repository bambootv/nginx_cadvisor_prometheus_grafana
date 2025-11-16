FROM nginx:1.27.0

# Remove the default server snippet to avoid duplicate listens
RUN rm -f /etc/nginx/conf.d/default.conf

# Copy nginx configurations
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/nginx_sites_available /etc/nginx/conf.d/default.conf

# Link logs to stdout/stderr (Docker best practice)
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Expose the necessary port
EXPOSE 80

# Use default nginx entrypoint
CMD ["nginx", "-g", "daemon off;"]
