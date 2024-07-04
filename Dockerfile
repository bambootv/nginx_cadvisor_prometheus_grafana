# Use the official Nginx base image
FROM nginx:1.27.0

# Install dependencies
RUN apt-get update && \
    apt-get install -y build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev wget git cron logrotate

# Download Nginx source code
RUN wget http://nginx.org/download/nginx-1.21.4.tar.gz && \
    tar -zxvf nginx-1.21.4.tar.gz

# Change to the source directory
WORKDIR nginx-1.21.4

# Configure and compile Nginx with the stub status module
RUN ./configure --with-http_stub_status_module && \
    make && \
    make install

# Remove unnecessary files
RUN apt-get remove -y build-essential wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* nginx-1.21.4 nginx-1.21.4.tar.gz

# Copy the default configuration file
COPY nginx/nginx.conf /usr/local/nginx/conf/nginx.conf
COPY nginx/nginx_sites_available /etc/nginx/sites-available/default
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
