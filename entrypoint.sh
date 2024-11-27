#!/bin/bash

POWERADMIN_BASE_DIR=/var/www/html/

# 在这里写一个函数，删除 install 目录
function remove_install_dir() {
    rm -rf $POWERADMIN_BASE_DIR/install
}

# 检查 POWERADMIN_BASE_DIR/install 是否存在
if [ ! -d "$POWERADMIN_BASE_DIR/install" ]; then
    # 检查环境变量 POWERADMIN_SKIP_INSTALL 是否存在, 如果存在, 则删除整个 install 目录
    if [ "$POWERADMIN_SKIP_INSTALL" == "true" ]; then
        remove_install_dir
    fi

    # 否则，如果 /etc/poweradmin/skip_install 文件存在，则一样删除整个 install 目录
    if [ -f "/etc/poweradmin/skip_install" ]; then
        remove_install_dir
    fi
fi

# 到这里，执行 php-apache 原有的 entrypoint.sh
exec /usr/local/bin/docker-php-entrypoint "$@"
