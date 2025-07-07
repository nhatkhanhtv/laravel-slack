FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y apache2 \
                       mysql-client \
                       php \
                       php-mysql \
                       php-cli \
                       php-curl \
                       php-xml \
                       php-mbstring \
                       php-zip \
                       php-gd \
                       php-bcmath \
                       libapache2-mod-php \
                       vsftpd \
                       git \
                       unzip \
                       curl \
                       composer

RUN a2enmod rewrite

COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www/html

# Clone code hoặc copy
# RUN git clone https://github.com/your/repo.git .
COPY . .

RUN composer install

EXPOSE 80 21

CMD service vsftpd start && apachectl -D FOREGROUND
