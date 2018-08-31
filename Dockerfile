FROM php:fpm

RUN apt update
RUN apt install -y mysql-client

RUN docker-php-ext-install mysqli

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
