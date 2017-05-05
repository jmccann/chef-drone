# Drone cookbook
[![Build Status](https://travis-ci.org/jmccann/chef-drone.svg?branch=master)](https://travis-ci.org/jmccann/chef-drone)

Installs [Drone](https://github.com/drone/drone), a CI server built on [Docker](https://www.docker.io).

More information also @ http://readme.drone.io.

# Requirements

## Chef

* Chef 12+

## Platforms

This cookbook is tested against:

* Ubuntu 16.04
* CentOS 7.x

...but it might work on other platforms.

# Usage
## Recipes
### drone::default
Installs the drone server.

Include `recipe[drone::default]` in your run list.

### drone::agent
Installs and sets up the drone agent.

Include `recipe[drone::agent]` in your run list.

## Attributes

For Drone ENV config settings see:
* http://readme.drone.io/admin/installation-reference/ - Drone 0.5
* http://docs.drone.io/installation/ - Drone 0.6

Attribute | Description | Type | Default
----------|-------------|------|--------
`node['drone']['repo']` | Docker repo to pull Drone from | String | `'drone/drone'`
`node['drone']['version']` | Version of Drone | String | `'0.4'`
`node['drone']['server']['port']` | Host port to bind drone to | Integer | `80`
`node['drone']['server']['volumes']` | Volumes to mount to drone from host | Array | `['/var/lib/drone:/var/lib/drone', '/var/run/docker.sock:/var/run/docker.sock']`
`node['drone']['vault']['bag']` | Name of vault with secrets | String | `'vault_drone'`.  See [Vault](#vault) section below.
`node['drone']['config']` | Hash of Drone ENV configuration options | Hash | See [Configuration](#configuration) section below.
`node['drone']['agent']['config']` | Hash of configuration options for Drone Agent | Hash | See [Configuration](#configuration) section below.

## Secrets With Chef-Vault

This cookbook supports using secrets from chef-vault.  The vault bag to use
is controlled by `node['drone']['vault']['bag']`.  Then the following vault
items are supported:

* drone_secret
* drone_github_client
* drone_github_secret
* database_config

## Docker

See `attributes/docker.rb` for more options.

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
