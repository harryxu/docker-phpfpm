FROM harryxu/phpfpm:8.2

ENV ACCEPT_EULA=Y

### The uopz extension is focused on providing utilities to aid with unit testing PHP code.
### Required by packages like ClockMock. https://github.com/slope-it/clock-mock
# RUN pecl install -o -f uopz && docker-php-ext-enable uopz

### Microsoft Drivers for PHP for SQL Server
### https://docs.microsoft.com/en-us/sql/connect/php/microsoft-php-driver-for-sql-server?view=sql-server-2017
# RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
# RUN curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list

# RUN apt-get update
# RUN apt-get install -y --no-install-recommends  msodbcsql17 unixodbc-dev

# RUN pecl install sqlsrv pdo_sqlsrv \
#     && docker-php-ext-enable sqlsrv pdo_sqlsrv
