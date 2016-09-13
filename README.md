# Drone cookbook
[![Build Status](https://travis-ci.org/jmccann/chef-drone.svg?branch=master)](https://travis-ci.org/jmccann/chef-drone)

Installs [Drone](https://github.com/drone/drone), a CI server built on [Docker](https://www.docker.io).

More information also @ http://readme.drone.io.

# Requirements

## Chef

* Chef 12+

## Platforms

This cookbook is tested against:

* Ubuntu 15.10
* Ubuntu 16.04
* CentOS 7.x

...but it might work on other platforms.

If installing and managing docker with this cookbook only version 1.11+ is supported.

# Usage
## Recipes
### drone::default
Installs the drone server.

Include `recipe[drone::default]` in your run list.

### drone::reverse_proxy
Fronts drone server with a reverse_proxy using nginx for HTTPS.

Include `recipe[drone::reverse_proxy]` in your run list.

### drone::worker
Installs and sets up the drone worker.  For use with Drone <= 0.4

Basically installs docker and exposes the socket over TCP for the Drone server to send builds to.

Include `recipe[drone::worker]` in your run list.

### drone::agent
Installs and sets up the drone agent.  For use with Drone >= 0.5

Include `recipe[drone::agent]` in your run list.

## Attributes

For Drone ENV config settings see:
* http://readme.drone.io/setup/overview/#configure - Drone 0.4
* http://readme.drone.io/0.5/manage/server/ - Drone 0.5

Attribute | Description | Type | Default
----------|-------------|------|--------
`node['drone']['version']` | Version of Drone | String | Default is `'0.4'`.  Tested some also with `'0.5'`
`node['drone']['vault']['bag']` | Name of vault with secrets | String | Default is `'vault_drone'`.  See [Vault](#vault) section below.
`node['drone']['config']` | Hash of Drone ENV configuration options | Hash | See [Configuration](#configuration) section below.
`node['drone']['agent']['config']` | Hash of configuration options for Drone Agent | Hash | See [Configuration](#configuration) section below.

## Configuration

The configuration in Drone 0.4.0 changed from TOML to BASH RC file.

The minimum required attribute is to set following tokens for your "remote" driver (gitlab, github, etc..)

* `node['drone']['config']['oauth_client']`
* `node['drone']['config']['oauth_secret']`

See the drone documentations and `attributes/default.rb` for more options.

## Vault

For [`drone::reverse_proxy`](#drone::reverse_proxy) you need:
* [certs](test/integration/data_bags/vault_drone/certs.json)

Other optional items include:
* drone_secret
* drone_github_client
* drone_github_secret
* database_config

## Docker

See `attributes/docker.rb` for more options.

**Note:** There is no ability to control docker version on RHEL based platforms.

## Testing

* Linting - Rubocop and Foodcritic
* Spec - ChefSpec
* Integration - Test Kitchen

Testing requires [ChefDK](https://downloads.chef.io/chef-dk/) be installed using it's native gems.

```
gem install docker-api
foodcritic -f any -X spec .
rubocop
rspec --color --format progress
```

If you run into issues testing please first remove any additional gems you may
have installed into your ChefDK environment.  Extra gems can be found and removed
at `~/.chefdk/gem`.
