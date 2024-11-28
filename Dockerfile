FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libicu-dev \
    libssl-dev \
    libsqlite3-dev \
    libpq-dev \
    gettext

RUN docker-php-ext-install -j$(nproc) \
    intl \
    gettext \
    pdo_pgsql \
    pdo_mysql

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["apache2-foreground"]

COPY poweradmin/ /var/www/html/