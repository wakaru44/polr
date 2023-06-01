FROM php:7.4-fpm-alpine3.11
RUN apk update; \
    apk upgrade;
RUN docker-php-ext-install mysqli pdo pdo_mysql

COPY . /var/www/html

RUN curl -sS https://getcomposer.org/installer > installer.php

RUN head installer.php && \
    echo foo  && \
    php installer.php --check

RUN php installer.php && \
    mv composer.phar /usr/local/bin/composer

RUN export COMPOSER_MEMORY_LIMIT=-1 && \
    ls -l  && \
    composer self-update --1 && \
    composer install --no-dev --no-interaction --optimize-autoloader


