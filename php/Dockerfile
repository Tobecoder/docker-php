FROM php:7.2-fpm

ENV TZ=Asia/Shanghai

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# source
# RUN rm -rf /etc/apt/sources.list
# ADD sources.list /etc/apt/
# php-ext

RUN apt-get update && apt-get install -y \
git \
wget \
libfreetype6-dev \
libjpeg62-turbo-dev \
libpng-dev \
supervisor \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j$(nproc) gd \
&& docker-php-ext-install zip \
&& docker-php-ext-install pdo_mysql \
&& docker-php-ext-install opcache \
&& docker-php-ext-install mysqli \
&& docker-php-ext-install bcmath \
&& docker-php-ext-install exif \
&& docker-php-ext-install gettext \
&& docker-php-ext-install sockets \
&& docker-php-ext-install pcntl \
&& docker-php-ext-install mysqli \
&& docker-php-ext-install sysvsem \
&& docker-php-ext-install shmop \
&& rm -r /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
libxml2-dev \
&& docker-php-ext-install soap \
&& docker-php-ext-install xmlrpc \
&& rm -r /var/lib/apt/lists/*

# libevent
#RUN apt-get update && \
#apt-get install -y libevent-dev && \
#pecl channel-update pecl.php.net && \
#pecl install libevent-0.1.0 && docker-php-ext-enable libevent \
#&& rm -r /var/lib/apt/lists/*

# intl
RUN apt-get update && \
docker-php-ext-install intl && docker-php-ext-enable intl \
&& rm -r /var/lib/apt/lists/*

# memcached
RUN apt-get update && apt-get install -y libmemcached-dev zlib1g-dev \
&& pecl install memcached \
&& docker-php-ext-enable memcached \
&& rm -r /var/lib/apt/lists/*

# redis && xdebug
RUN pecl install redis \
&& pecl install xdebug \
&& docker-php-ext-enable redis xdebug

# composer
ENV COMPOSER_HOME /root/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH $COMPOSER_HOME/vendor/bin:$PATH

# php.ini
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Write Permission
RUN usermod -u 1000 www-data