FROM php:7.1-fpm-stretch

ENV ACCEPT_EULA=Y

ADD ./sources.list /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        curl \
        gnupg \
        libz-dev \
        libpq-dev \
        libssl-dev \
        libmcrypt-dev \
        apt-transport-https

### Common ext
RUN docker-php-ext-install -j$(nproc) \
        iconv \
        mcrypt \
        mbstring \
        mysqli \
        zip \
        pdo \
        pdo_mysql

### iconv and gd extensions
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

### imagick
RUN apt-get -y install libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick

### exif
RUN docker-php-ext-install exif
RUN docker-php-ext-configure exif --enable-exif


### Microsoft Drivers for PHP for SQL Server
### https://docs.microsoft.com/en-us/sql/connect/php/microsoft-php-driver-for-sql-server?view=sql-server-2017
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update
RUN apt-get install -y --no-install-recommends  msodbcsql17 unixodbc-dev

RUN pecl install sqlsrv pdo_sqlsrv \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv

### Image optimization tools
RUN apt-get install -y --no-install-recommends jpegoptim optipng pngquant
