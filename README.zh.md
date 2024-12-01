# poweradmin-docker

[English](./README.md) | 中文

# 警告！！！这不是官方镜像！！！
官方仓库在这里: [poweradmin/poweradmin](https://github.com/poweradmin/poweradmin)  
这个镜像的仓库在这: [LamGC/poweradmin-docker](https://github.com/LamGC/poweradmin-docker)  

对于 PowerAdmin 的问题，你应该前往 [poweradmin/poweradmin](https://github.com/poweradmin/poweradmin) 进行反馈，如果是 Docker 部署的问题，
可以在 [LamGC/poweradmin-docker](https://github.com/LamGC/poweradmin-docker) 反馈。

## 使用方法

### 通过 Docker Compose 部署

下面是一个简单的 PowerAdmin Docker Compose 配置, 你需要根据自身需求或者部署方式，增加 MySQL 数据库（或者其他的，只要 PowerAdmin 和 PowerDNS-auth 支持就行）和 PowerDNS-auth 的配置。

> 如果你想要一个完整的配置，可以看看 [example](example/) 目录，里面包含一个基本的 PowerDNS + PowerAdmin + MySQL 的 Docker Compose 配置。

```yaml
services:
  pdns-admin:
    image: lamgc/poweradmin:latest
    container_name: powerdns_admin
    ports:
      - "9191:80"
    logging:
      driver: json-file
      options:
        max-size: 50m
    environment:
      # 你执行完 PowerAdmin 的所有安装步骤后，取消下面的注释，请求容器删除安装目录。
      # POWERADMIN_SKIP_INSTALL: true
```

使用这个配置启动后，按照 PowerAdmin 的说明执行完安装程序，然后添加 `POWERADMIN_SKIP_INSTALL: true` 环境变量，
重建 Docker Compose 容器组后，容器将会删除 PowerAdmin 的 install 目录。


### 直接使用 `docker run` 命令

如果你不想使用 Docker Compose，那么可以使用这个命令：

```bash
$ docker run -d --name pdns_admin --restart unless-stopped -v /path/to/pdns_admin_conf:/etc/poweradmin/ -p 9191:80 lamgc/poweradmin:latest
```

> 注意：将 `/path/to/pdns_admin_conf` 替换为一个空目录的路径！

使用这个配置启动后，按照 PowerAdmin 的说明执行完安装程序，然后在 `/path/to/pdns_admin_conf` 目录中，
执行指令 `touch skip_install` 创建一个名为 `skip_install` 的空文件，然后重启 PowerAdmin 容器以删除 install 目录。

# 关于镜像更新

该镜像将每天检查 PowerAdmin 的最新版本，并自动构建镜像。

# 许可

本项目 [lamgc/poweradmin](https://github.com/lamgc/poweradmin) 依据 [Apache 许可证 2.0](https://www.apache.org/licenses/LICENSE-2.0) 开源。

```plaintext
版权所有 2024 lamgc

根据 Apache 许可证 2.0 版（以下简称“许可证”）许可，除非遵守本许可证，否则您不能使用此文件。
您可以在以下地址获取许可证副本：

    http://www.apache.org/licenses/LICENSE-2.0

除非适用法律要求或书面同意，根据许可证分发的软件按“原样”分发，不提供任何明示或暗示的担保或条件。
请参阅许可证以了解管理权限和限制的具体语言。
```

> 希望这个项目可以为 Docker 使用者节省部署 PowerAdmin 的时间！
