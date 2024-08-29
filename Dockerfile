FROM ubuntu:24.04

#ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    wget \
    curl 
RUN add-apt-repository ppa:ondrej/php -y && \
    apt-get update -y && \
    apt-get install -y \
    apache2 \
    php8.3 \
    php8.3-fpm \
    php8.3-imap \
    php8.3-ldap \
    php8.3-xml \
    php8.3-curl \
    php8.3-mbstring \
    php8.3-mysql \
    php8.3-bcmath \
    php8.3-bz2 \
    php8.3-intl \
    php8.3-gd \
    php8.3-zip \
    php8.3-common \
    php8.3-imagick \
    php8.3-memcached \
    php8.3-memcache \
    libapache2-mod-php8.3 && \
    # Clean up
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and set up phpMyAdmin
RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz && \
    tar xvf phpMyAdmin-latest-all-languages.tar.gz && \
    mv phpMyAdmin-*-all-languages /usr/share/phpmyadmin && \
    mkdir /usr/share/phpmyadmin/tmp && \
    chown -R www-data:www-data /usr/share/phpmyadmin && \
    chmod 777 /usr/share/phpmyadmin/tmp && \
    echo '<?php phpinfo(); ?>' > /var/www/html/info.php

# Copy phpMyAdmin configuration file
COPY phpmyadmin.conf /etc/apache2/conf-available/

# Enable phpMyAdmin configuration and necessary Apache modules
RUN a2enconf phpmyadmin && \
    a2enmod php8.3 && \
    a2enmod rewrite

# Set the command to run Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
