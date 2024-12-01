# poweradmin-docker

English | [中文](./README.zh.md)

# Warning, this is an unofficial image!!!
Official repository: [poweradmin/poweradmin](https://github.com/poweradmin/poweradmin)

## Usage

### Using Docker Compose

A simple PowerAdmin configuration is as follows, you should add container configurations for MySQL 
or other supported databases as needed, as well as container configurations for PowerDNS auth.

> If you want a complete configuration, you can take a look at the [example](example/) directory, which contains a basic Docker Compose configuration for PowerDNS + PowerAdmin + MySQL.

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
    volumes:
      # When you encounter the issue of being unable to save the installation configuration during installation, 
      # please write the content to this host path, and remove the annotation for the mapping in the following line.

      # - "./pdns_admin_config/config.inc.php:/var/www/html/inc/config.inc.php"
    environment:
      # When you have completed all the installation steps of PowerAdmin, 
      # please uncomment this environment variable below to request the removal of the install directory.
      
      # POWERADMIN_SKIP_INSTALL: true
```

After starting with this configuration, follow PowerAdmin's instructions to complete the installation program, 
and then add the `POWERADMIN_SKIP_INSTALL: true` environment variable,
After rebuilding the Docker Compose container group, the container will delete the install directory of PowerAdmin.

### Using `docker run` command

If you don't want to use Docker Compose, you can use this command:

```bash
$ docker run -d --name pdns_admin --restart unless-stopped -v /path/to/pdns_admin_conf:/etc/poweradmin/ -p 9191:80 lamgc/poweradmin:latest
```

> Note: Replace `/path/to/pdns_admin_conf` with the path of an empty directory!

After starting with this configuration, follow the instructions provided by PowerAdmin to complete the installation process. 
Then, navigate to the `/path/to/pdns_admin_conf` directory, Execute the command `touch skip_install` to create an empty file named `skip_install`, 
and then restart the PowerAdmin container to delete the install directory.

# About image updates

The image will check for the latest version of PowerAdmin daily and automatically build the image.

## License

This project [lamgc/poweradmin](https://github.com/lamgc/poweradmin) is open-sourced under the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).

```plaintext
Copyright 2024 lamgc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

> I hope this project can save Docker users time in deploying PowerAdmin! Enjoy~
