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

## default

These attributes are under the `node['drone']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
package_url | URL of the Drone package to download and install | String | [http://downloads.drone.io/latest/drone.deb](http://downloads.drone.io/latest/drone.deb)
temp_file | Path to store the downloaded package | String | /tmp/drone.deb
config_file | Location of Drone config file | String | /etc/init/drone.conf
droned_opts | Options to use when running Drone | String | --port=:80

## nginx

These attributes are under the `node['drone']['nginx']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
hostname | full URI to be used | String | drone.example.com
aliases | nginx aliases | Array | ['drone']
listen | IP to listen on | String | 0.0.0.0
port | Port to listen on | String | 80
template | nginx template for non-ssl | String | drone-nginx.conf.erb
enable_ssl | use SSL | String | true
ssl_listen | ssl IP to listen on | String | 0.0.0.0
ssl_port | ssl port to listen on | String | 443
ssl_template | nginx template for ssl | String | ssl-drone-nginx.conf.erb
ssl_key | SSL Key | String | ...
ssl_cert | SSL Cert | String | ...
template_cookbook | cookbook where template resides | String | drone

# Recipes

* `recipe[drone::default]` Installs/Configures Drone
* `recipe[drone::nginx]` Installs/Configures basic/SSL reverse proxy in front of drone.
