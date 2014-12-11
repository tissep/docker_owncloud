FROM ubuntu:14.04
MAINTAINER	Chris Pettersson

RUN         apt-get update && \
            apt-get install -y php5-cli php5-gd php5-pgsql php5-curl php5-intl php5-mcrypt \
	    php5-ldap php5-gmp php5-apcu php5-imagick php5-fpm smbclient nginx

ADD         bootstrap.sh /usr/bin/
ADD         nginx_ssl.conf /root/
ADD         nginx.conf /root/
ADD         owncloud-7.0.4.tar.bz2 /var/www/

RUN         chown -R www-data:www-data /var/www &&\
            chmod +x /usr/bin/bootstrap.sh

ADD         php.ini /etc/php5/fpm/

EXPOSE      443

VOLUME      /var/www/owncloud/data
VOLUME      /var/www/owncloud/config
VOLUME      /root/ssl

ENTRYPOINT  ["bootstrap.sh"]

