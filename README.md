# Composer
Dockerized PHP dependency manager. It allows you to declare the libraries your project depends on and it will manage (install/update) them for you.

* #### Current Tags:

  - PHP: **`v7.3.9`**
  - Composer: **`v1.9.0`**

* #### Add shortcut functions via .bashrc or .zshrc

```bash
composer() { 
    docker run --rm -it \
    --workdir /src \
    --volume "$(pwd)":/src \
    --user $(id -u):$(id -g) \
    pam79/composer "$@"; 
}
```
&nbsp;

* #### Source file to apply changes

    ```bash
    $ source ~/.bashrc
    ```
&nbsp;

* #### Or just export it with a wrapper script as a global binary
```bash
$ mkdir -p scripts && cd scripts
$ vim composer.sh
```

Add the following content into `composer.sh` file
```bash
#!/bin/sh

# A wrapper script for invoking composer with docker
# Put this script in $PATH as `composer`

VERSION="latest"

exec docker run -it --rm \
    --volume "$PWD":/src \
    --workdir /src \
    --user $(id -u):$(id -g) \
    "pam79/composer:$VERSION" "$@"
```

Install the script
```bash
$ sudo install -m 0755 composer.sh /usr/local/bin/composer
```

Verify if the script was installed
```bash
$ whereis composer
```

* The shortcut function or binary can be used as follows:
```bash
$ composer --version
$ composer install --no-dev
```

Checkout Composer's [**official site**](https://getcomposer.org/) for more details.
