FROM pam79/php-fpm
LABEL maintainer="Abdullah Morgan <paapaabdullahm@gmail.com>"

# Add Composer
RUN apt update; apt install -y curl git openssh-server openssl bash; \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === \
        '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') \
        { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"; \
    php composer-setup.php; \
    php -r "unlink('composer-setup.php');"; \
    mv composer.phar /usr/bin/composer

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /src
VOLUME /src

ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
CMD ["composer"]
