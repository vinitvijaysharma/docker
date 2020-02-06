FROM ubuntu:bionic
MAINTAINER vinit sharma <vinitatmail@gmail.com>

ENV OS_LOCALE="en_US.UTF-8"
ENV TERM=linux

ENV LANG=${OS_LOCALE} \
    LANGUAGE=${OS_LOCALE} \
    LC_ALL=${OS_LOCALE} \
    DEBIAN_FRONTEND=noninteractive
# create env and locale
RUN apt-get update && apt-get install -y locales && locale-gen ${OS_LOCALE}

RUN	\
    BUILD_DEPS='software-properties-common' \
    && dpkg-reconfigure locales \
	&& apt-get install --no-install-recommends -y $BUILD_DEPS \
	&& add-apt-repository -y ppa:ondrej/php \
	&& add-apt-repository -y ppa:ondrej/apache2 \
	&& apt-get install apt-utils \
	&& apt-get update


ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

ENV APACHE_CONF_DIR=/etc/apache2 \
    PHP_CONF_DIR=/etc/php/7.4 \
    PHP_DATA_DIR=/var/lib/php

#install apache 2
RUN apt-get update && apt-get -y install apache2 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN /usr/sbin/a2ensite default-ssl
RUN /usr/sbin/a2enmod ssl

# install php 7.4 and php lib
RUN apt-get update && apt-get install -y  php7.4
RUN apt-get update && apt-get install -y curl git  libapache2-mod-php7.4 php7.4-cli php7.4-readline php7.4-mbstring php7.4-zip php7.4-intl php7.4-xml php7.4-json php7.4-curl php7.4-gd php7.4-pgsql php7.4-mysql php-pear php-zip php7.4-dom && apt-get clean && rm -rf /var/lib/apt/lists/*

#enabling php fpm
RUN /usr/sbin/a2enmod mpm_prefork
RUN /usr/sbin/a2enmod rewrite

ADD 000-laravel.conf /etc/apache2/sites-available/
ADD 001-laravel-ssl.conf /etc/apache2/sites-available/
RUN /usr/sbin/a2dissite '*' && /usr/sbin/a2ensite 000-laravel 001-laravel-ssl

RUN /usr/bin/curl -sS https://getcomposer.org/installer | /usr/bin/php
RUN /bin/mv composer.phar /usr/local/bin/composer
RUN /usr/local/bin/composer create-project --prefer-dist laravel/laravel /var/www/laravel  "5.6.*"  
RUN /bin/chown www-data:www-data -R /var/www/laravel/storage /var/www/laravel/bootstrap/cache

WORKDIR /var/www/laravel/

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
