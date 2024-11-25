FROM php:8.1-apache

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libpq-dev \
    libicu-dev \
    libzip-dev \
    && docker-php-ext-install pdo pdo_mysql intl zip && \
    docker-php-ext-configure intl && \
    rm -rf /var/lib/apt/lists/*

# Configure Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    a2enmod rewrite

WORKDIR /var/www/html

RUN curl -sL https://github.com/roundcube/roundcubemail/releases/download/1.6.4/roundcubemail-1.6.4-complete.tar.gz | tar xz --strip 1

# Create required directories and set permissions
RUN mkdir -p /var/www/html/temp /var/www/html/logs && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 777 /var/www/html/temp /var/www/html/logs

# Remove installer after setup
RUN rm -rf /var/www/html/installer

COPY config.inc.php /var/www/html/config/config.inc.php

# Enable PHP error logging
RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/error-logging.ini && \
    echo "display_errors = On" >> /usr/local/etc/php/conf.d/error-logging.ini && \
    echo "log_errors = On" >> /usr/local/etc/php/conf.d/error-logging.ini && \
    echo "error_log = /dev/stderr" >> /usr/local/etc/php/conf.d/error-logging.ini