FROM php:7.2-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev mc gnupg2 git gnupg libxml2-dev libzip-dev zip unzip libc-client-dev libkrb5-dev \
     mysql-client libmagickwand-dev --no-install-recommends \
     && pecl install imagick \
     && docker-php-ext-enable imagick \
     && docker-php-ext-install pdo_mysql mysqli zip calendar xml mbstring json iconv ctype
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
     && docker-php-ext-install imap

RUN echo "Install node js..." \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs \
    && echo "Install composer and npm..." \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

