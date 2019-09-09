FROM pam79/php-fpm
LABEL maintainer="Abdullah Morgan <paapaabdullahm@gmail.com>"

# Add Composer
RUN apt update; apt install -y curl git openssh-server openssl bash; \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === \
        'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') \
        { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"; \
    php composer-setup.php; php -r "unlink('composer-setup.php');"; mv composer.phar /usr/bin/composer

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /src
VOLUME /src

ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
CMD ["composer"]
