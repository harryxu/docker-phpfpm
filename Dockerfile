FROM php:7.4-fpm-buster

ENV ACCEPT_EULA=Y

ADD ./sources.list /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        curl \
        gnupg \
        libz-dev \
        libzip-dev \
        libpq-dev \
        libssl-dev \
        libmcrypt-dev \
        libxml2-dev \
        apt-transport-https \
        ffmpeg \
        jpegoptim optipng pngquant

### Common ext
RUN docker-php-ext-install -j$(nproc) \
        mysqli \
        zip \
        pdo_mysql \
        bcmath \
        exif \
        soap

### iconv and gd extensions
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

### redis
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

### imagick
# RUN apt-get -y install libmagickwand-dev --no-install-recommends \
#     && pecl install imagick \
#     && docker-php-ext-enable imagick

### exif
# RUN docker-php-ext-install exif \
#     && docker-php-ext-configure exif --enable-exif


### Microsoft Drivers for PHP for SQL Server
### https://docs.microsoft.com/en-us/sql/connect/php/microsoft-php-driver-for-sql-server?view=sql-server-2017
# RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
# RUN curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list

# RUN apt-get update
# RUN apt-get install -y --no-install-recommends  msodbcsql17 unixodbc-dev

# RUN pecl install sqlsrv pdo_sqlsrv \
#     && docker-php-ext-enable sqlsrv pdo_sqlsrv
