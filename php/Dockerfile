FROM php:7.2-fpm

ENV TZ=Asia/Shanghai

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# php-ext

RUN apt-get update && apt-get install -y \
git \
libfreetype6-dev \
libjpeg62-turbo-dev \
libpng-dev \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j$(nproc) gd \
&& docker-php-ext-install zip \
&& docker-php-ext-install pdo_mysql \
&& docker-php-ext-install opcache \
&& docker-php-ext-install mysqli \
&& docker-php-ext-install bcmath \
&& rm -r /var/lib/apt/lists/*

# redis

COPY ./redis-4.1.1.tgz /home/redis-4.1.1.tgz

RUN pecl install /home/redis-4.1.1.tgz && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

# composer

ENV COMPOSER_HOME /root/composer

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV PATH $COMPOSER_HOME/vendor/bin:$PATH

RUN rm -f /home/redis-4.1.1.tgz

# Write Permission

RUN usermod -u 1000 www-data
