#!/bin/bash

POWERADMIN_BASE_DIR=/var/www/html/

function remove_install_dir() {
    rm -rf $POWERADMIN_BASE_DIR/install
}

echo 'Checking install directory...'
if [ -d "$POWERADMIN_BASE_DIR/install" ]; then
    if [ "$POWERADMIN_SKIP_INSTALL" == "true" ] || [ -f "/etc/poweradmin/skip_install" ]; then
        echo 'Deleting install directory...'
        remove_install_dir
    else
        echo 'Unable to find the flag to remove install, keep the install directory.'
    fi

else
    echo 'Cannot find the install directory, no action is required.'
fi

echo 'Starting Apache server...'
/usr/local/bin/docker-php-entrypoint "$@"
