# Drone cookbook

[![Build Status](https://travis-ci.org/justincampbell/chef-drone.png?branch=master)](https://travis-ci.org/justincampbell/chef-drone)

Installs [Drone](https://github.com/drone/drone), a CI server built on [Docker](https://www.docker.io).

# Requirements

## Chef

* Chef 11+

## Platforms

This cookbook is tested against:

* Ubuntu 12.04
* Ubuntu 14.04

...but it might work on other platforms.

# Usage

Include `recipe[drone]` in your run list.

# Attributes

These attributes are under the `node['drone']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
package_url | URL of the Drone package to download and install | String | [http://downloads.drone.io/master/drone.deb](http://downloads.drone.io/master/drone.deb)
temp_file | Path to store the downloaded package | String | /tmp/drone.deb
config_file | Location of Drone config file | String | /etc/init/drone.conf
config | Hash of configuration options | Hash | See Config section below

# Configuration

The configuration in Drone 0.4.0 changed from TOML to BASH RC file.

The minimum required attribute is to set following tokens for your "remote" driver (gitlab, github, etc..)

    node['drone']['oauth_client']
    node['drone']['oauth_secret']

See the drone documentations and `attributes/default.rb` for more options.

You may also include `drone::docker` recipe or set node['drone']['install_docker'] to install docker on your host. See `attributes/docker.rb` for more options.

# Recipes

* `recipe[default]` Installs/Configures Drone
* `recipe[docker]`  Installs/Configures Docker
* `recipe[update]`  If docker cookbook is used, you may use this recipe to update drone images regularly. (not yet implemented)

