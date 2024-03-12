FROM php:8.1-apache

RUN apt-get update && apt-get -y install libicu-dev wget gnupg tar gzip g++ zlib1g-dev libpng-dev
RUN docker-php-ext-install mysqli pdo_mysql gd intl && \
    docker-php-ext-enable intl

WORKDIR /var/www/html
RUN wget https://releases.wikimedia.org/mediawiki/1.41/mediawiki-1.41.0.tar.gz && \
    tar -xvf mediawiki-1.41.0.tar.gz && \
    ln -s mediawiki-1.41.0/ mediawiki
