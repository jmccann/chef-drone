# Drone cookbook
[![Build Status](https://travis-ci.org/justincampbell/chef-drone.png?branch=master)](https://travis-ci.org/justincampbell/chef-drone)

Installs [Drone](https://github.com/drone/drone), a CI server built on [Docker](https://www.docker.io).

# Requirements

## Chef

* Chef 11+

## Platforms

* Ubuntu 12.04
* Ubuntu 12.10
* Ubuntu 13.04
* Ubuntu 13.10 (Experimental)

# Usage

Include `recipe[drone]` in your run list.

# Attributes

These attributes are under the `node['drone']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
package_url | URL of the Drone package to download and install | String | [http://downloads.drone.io/latest/drone.deb](http://downloads.drone.io/latest/drone.deb)
temp_file | Path to store the downloaded package | String | /tmp/drone.deb
config_file | Location of Drone config file | String | /etc/init/drone.conf
droned_opts.port | port to use when running Drone | String | :80
droned_opts.driver | database driver use when running Drone | String | sqlite3
droned_opts.datasource | dsn to use when running Drone | String | drone.sqlite

These attributes are used when `droned_opts.driver` is set to `mysql`

Attribute | Description | Type | Default
----------|-------------|------|--------
mysql.host | mysql host to use when running Drone | String | localhost
mysql.install | set to install mysql and create drone database/users | Boolean | true
mysql.database | mysql database to use when running Drone | String | drone
mysql.username | mysql username to use when running Drone | String | drone
mysql.password | mysql password to use when running Drone | String | drone

# Recipes

* `recipe[drone]` Installs/Configures Drone
