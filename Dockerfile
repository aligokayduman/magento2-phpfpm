FROM php:7.4-fpm

MAINTAINER A. Gökay Duman <smyrnof@gmail.com>

# General Commands
RUN apt update 

# Php-Fpm Install
RUN apt install -y libcurl4-openssl-dev \
                   libfreetype6-dev \
                   libjpeg62-turbo-dev \
                   libpng-dev \
                   libgd-dev \
                   libmcrypt-dev \
                   libxml2-dev \
                   libxslt-dev \
                   libc-client-dev \
                   libkrb5-dev \
    && rm -r /var/lib/apt/lists/* \               
    && pecl install redis-5.0.2 \
    && pecl install xdebug-2.7.2 \
    && docker-php-ext-enable redis xdebug \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install -j$(nproc) imap \
    && docker-php-ext-install bcmath \
                              intl \
                              opcache \
                              mysqli \
                              pdo \
                              pdo_mysql \
                              curl \                           
                              mbstring \
                              hash \
                              simplexml \
                              soap \
                              xml \
                              xsl \
                              zip \
                              json
                              
RUN useradd docker-usr \
    && usermod -aG www-data docker-usr \
    && usermod -aG root www-data
