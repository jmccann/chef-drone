# Drone Cookbook
[![Build Status](https://travis-ci.org/jmccann/chef-drone.svg?branch=master)](https://travis-ci.org/jmccann/chef-drone)

Installs [Drone](https://github.com/drone/drone), a CI server built on [Docker](https://www.docker.io).

More information also @ http://docs.drone.io.

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

### drone::agent
Installs and sets up the drone agent.  Assumes you have already setup and configured docker.

Include `recipe[drone::agent]` in your run list.

### drone::server
Installs the drone server.  Assumes you have already setup and configured docker.

Include `recipe[drone::server]` in your run list.

### drone::standalone_agent
Installs the drone agent.
Also will install and configure docker with [jmccann-docker-host cookbook](https://github.com/jmccann/jmccann-docker-host-cookbook).

Include `recipe[drone::standalone_agent]` in your run list.

### drone::standalone_server
Installs the drone server.
Also will install and configure docker with [jmccann-docker-host cookbook](https://github.com/jmccann/jmccann-docker-host-cookbook).

Include `recipe[drone::standalone_server]` in your run list.

## Attributes

Attribute | Description | Type | Default
----------|-------------|------|--------
`node['drone']['agent']['config']` | Hash of configuration envvars for Drone Agent | Hash | See [Configuration](#configuration) section below.
`node['drone']['agent']['repo']` | Docker repo to pull Drone Agent from | String | `'drone/agent'`
`node['drone']['agent']['network_mode']` | What network mode to start Drone agent with. Default from Docker is `bridge`. | String | `nil`
`node['drone']['agent']['vault']['items']` | Array of vault items to load from bag for agents | Array | `['drone_secret']`
`node['drone']['agent']['volumes']` | Volumes to mount to drone from host for agent | Array | `['/var/run/docker.sock:/var/run/docker.sock']`
`node['drone']['server']['config']` | Hash of configuration envvars for Drone Server | Hash | See [Configuration](#configuration) section below.
`node['drone']['server']['network_mode']` | What network mode to start Drone server with. Default from Docker is `bridge`. | String | `nil`
`node['drone']['server']['port']` | Docker port configuration for server.  Binds container 8000 to host 80 and exposes port 9000 by default. | Array | `['80:8000', '9000:9000']`
`node['drone']['server']['repo']` | Docker repo to pull Drone Server from | String | `'drone/drone'`
`node['drone']['server']['vault']['items']` | Array of vault items to load from bag for server | Array | `['database_config' 'drone_database_datasource' 'drone_github_client' 'drone_github_secret' 'drone_license' 'drone_secret']`
`node['drone']['server']['volumes']` | Volumes to mount to drone from host for server | Array | `['/var/lib/drone:/var/lib/drone', '/var/run/docker.sock:/var/run/docker.sock']`
`node['drone']['vault']['bag']` | Name of vault with secrets | String | `'vault_drone'`.  See [Vault](#vault) section below.
`node['drone']['version']` | Version of Drone | String | `'0.8'`

## Configuration

Drone is configured by setting certain ENV variables in the agent/server containers.

For Drone ENV config settings see:
* http://docs.drone.io/installation/ - Drone 0.8

With this cookbook you can inject ENV variables to your Drone agent/server
containers by using `node['drone']['agent']['config']`
and `node['drone']['server']['config']`.  The keys after `config` are the
ENV variable names and the value you set is the value to assign the
ENV variable.

You can find examples of this in use in the [.kitchen.yml](.kitchen.yml)

## Secrets With Chef-Vault

This cookbook supports using secrets from chef-vault.  The vault bag to use
is controlled by `node['drone']['vault']['bag']`.  Vault items that are loaded
are controlled by the `default['drone']['agent']['vault']['items']`
and `default['drone']['server']['vault']['items']` attributes.

## HTTPS Config

Drone has the ability to terminate SSL connections.  This cookbook doesn't do
this for you but supports being able to do it.

1. Add your cert and private key to the host
  * https://github.com/zuazo/ssl_certificate-cookbook
2. Expose the certificates to the Drone container using `node['drone']['server']['volumes']`
```ruby
node['drone']['server']['volumes'] = [
  "/var/lib/drone:/var/lib/drone",
  "/var/run/docker.sock:/var/run/docker.sock",
  "/etc/ssl/certs/drone.pem:/etc/ssl/certs/drone.pem",
  "/etc/ssl/private/drone.key:/etc/ssl/private/drone.key"
]
```
3. Configure Drone to use the cert/key pair
```ruby
node['drone']['config']['drone_server_cert'] = '/etc/ssl/certs/drone.pem'
node['drone']['config']['drone_server_key'] = '/etc/ssl/private/drone.key'
```
4. Expose Drone service via host port 443
```ruby
node['drone']['server']['port'] = '443:8000'
```

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
