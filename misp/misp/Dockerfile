FROM php:7.2-apache
LABEL maintainer "Ilya Glotov <ilya@ilyaglotov.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV MISP_VERSION 2.4.95

RUN apt-get update \
  && apt-get install -y git \
                        libedit-dev \
                        libxml2-dev \
                        python3 \
                        python3-pip \
                        sudo \
                        unzip \
                        \
  && pip3 install zmq \
                  redis \
                  \
  && pecl install cli \
                  redis \
                  \
  && pear install Crypt_GPG \
                  Net_GeoIP \
                  \
  && docker-php-ext-install json \
                            opcache \
                            pdo \
                            pdo_mysql \
                            readline \
                            xml \
                            \
  && docker-php-ext-enable redis \
  \
  && git clone --branch=v${MISP_VERSION} --depth=1 https://github.com/MISP/MISP.git /var/www/MISP \
  && cd /var/www/MISP \
  && git submodule init \
  && git submodule update \
  \
  && cp /var/www/MISP/INSTALL/apache.misp.ubuntu ${APACHE_CONFDIR}/sites-available/misp.conf \
  && a2ensite misp \
  && a2enmod rewrite \
             headers \
  && a2dismod status \
  && a2dissite 000-default \
  && chown -R www-data:www-data /var/www/MISP \
  \
  && cd /var/www/MISP/app \
  && sudo -u www-data php composer.phar config vendor-dir Vendor \
  && sudo -u www-data php composer.phar install --ignore-platform-reqs \
  && cd /var/www/MISP/app/Config \
  && chown -R www-data:www-data /var/www/MISP \
  \
  && mv bootstrap.default.php bootstrap.php \
  && mv config.default.php config.php \
  && mv core.default.php core.php \
  \
  && rm -rf /var/lib/apt/lists/*

COPY php.ini /usr/local/etc/php/php.ini
