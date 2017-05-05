# Drone Cookbook
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

Attribute | Description | Type | Default
----------|-------------|------|--------
`node['drone']['repo']` | Docker repo to pull Drone from | String | `'drone/drone'`
`node['drone']['version']` | Version of Drone | String | `'0.4'`
`node['drone']['server']['port']` | Host port to bind drone to | Integer | `80`
`node['drone']['server']['volumes']` | Volumes to mount to drone from host | Array | `['/var/lib/drone:/var/lib/drone', '/var/run/docker.sock:/var/run/docker.sock']`
`node['drone']['vault']['bag']` | Name of vault with secrets | String | `'vault_drone'`.  See [Vault](#vault) section below.
`node['drone']['agent']['config']` | Hash of configuration envvars for Drone Agent | Hash | See [Configuration](#configuration) section below.
`node['drone']['server']['config']` | Hash of configuration envvars for Drone Server | Hash | See [Configuration](#configuration) section below.

## Configuration

Drone is configured by setting certain ENV variables in the agent/server containers.

For Drone ENV config settings see:
* http://readme.drone.io/admin/installation-reference/ - Drone 0.5
* http://docs.drone.io/installation/ - Drone 0.6

With this cookbook you can inject ENV variables to your Drone agent/server
containers by using `node['drone']['agent']['config']`
and `node['drone']['server']['config']`.  The keys after `config` are the
ENV variable names and the value you set is the value to assign the
ENV variable.

You can find examples of this in use in the [.kitchen.yml](.kitchen.yml)

## Secrets With Chef-Vault

This cookbook supports using secrets from chef-vault.  The vault bag to use
is controlled by `node['drone']['vault']['bag']`.  Then the following vault
items are supported:

* drone_secret
* drone_github_client
* drone_github_secret
* database_config

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
node['drone']['server']['port'] = '443'
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
