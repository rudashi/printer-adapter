FROM php:8.3-fpm-alpine as builder

RUN apk update && apk add --no-cache \
    $PHPIZE_DEPS \
    linux-headers \
    git

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN curl -sLS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Configure Xdebug
RUN echo "xdebug.mode=develop,debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

ENV PATH="$PATH:/usr/local/bin"