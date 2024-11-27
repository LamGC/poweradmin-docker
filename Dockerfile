FROM php:8.1-apache

RUN apt update && apt install -y php-intl php-gettext php-openssl php-filter php-tokenizer php-pdo \
                php-mysqlnd php-pgsql php-sqlite3

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

COPY poweradmin/ /var/www/html/