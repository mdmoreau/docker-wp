FROM php:fpm

ARG UID=1000
ARG GID=1000

RUN apt update
RUN apt install -y mysql-client libjpeg62-turbo-dev libpng-dev

RUN docker-php-ext-configure gd --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install mysqli gd

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN mkdir /var/www/.wp-cli
RUN chown www-data:www-data /var/www/.wp-cli

RUN usermod -u $UID www-data
RUN groupmod -g $GID www-data

USER www-data
