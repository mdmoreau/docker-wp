FROM php:7.4-fpm

ARG UID=$UID
ARG GID=$GID

RUN apt update
RUN apt install -y mariadb-client libfreetype6-dev libjpeg62-turbo-dev libpng-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install mysqli gd

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN mkdir /var/www/.wp-cli
RUN chown www-data:www-data /var/www/.wp-cli

RUN usermod -u $UID www-data
RUN groupmod -g $GID www-data

USER www-data
