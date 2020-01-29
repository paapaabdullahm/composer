FROM pam79/php-fpm:v7.4.1
LABEL maintainer="Abdullah Morgan <paapaabdullahm@gmail.com>"

# Add Tini init
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# Add Composer
RUN apt update && apt install -y bash curl git openssh-server openssl unzip; \
    #
    # Download the installer to the current directory
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; \
    #
    # Verify the installer SHA-384
    php -r "if (hash_file('SHA384', 'composer-setup.php') === \
        'baf1608c33254d00611ac1705c1d9958c817a1a33bce370c0595974b342601bd80b92a3f46067da89e3b06bff421f182') \
        { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"; \
    #
    # Run the installer
    php composer-setup.php; \
    #
    # Make binary globally accessible
    mv composer.phar /usr/bin/composer; \
    #
    # Clean up
    php -r "unlink('composer-setup.php');";

COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /src
VOLUME /src

ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]
CMD ["composer"]
