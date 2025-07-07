# Base image
FROM ubuntu:22.04

# Tắt prompt khi cài
ENV DEBIAN_FRONTEND=noninteractive

# Update & install packages
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
                       curl && \
    rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy virtual host config if needed (Optional)
# COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# FTP config: copy custom vsftpd.conf nếu bạn có (Optional)
# COPY ./vsftpd.conf /etc/vsftpd.conf

# Tạo user FTP (tùy chỉnh)
RUN useradd -m ftpuser && echo "ftpuser:ftppassword" | chpasswd

# Apache document root => Laravel sẽ đặt ở /var/www/html
WORKDIR /var/www/html

# Clone repo (nếu muốn)
# RUN git clone https://github.com/your/repo.git .

# Expose ports: 80 (HTTP), 21 (FTP)
EXPOSE 80 21

# Khởi động Apache & FTP khi container start
CMD service vsftpd start && apachectl -D FOREGROUND
RUN curl -sS https://getcomposer.org/installer | php && \
    php composer.phar install

COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf