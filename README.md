# Drone cookbook
[![Build Status](https://travis-ci.org/jmccann/chef-drone.svg?branch=master)](https://travis-ci.org/jmccann/chef-drone)

Installs [Drone](https://github.com/drone/drone), a CI server built on [Docker](https://www.docker.io).

# Requirements

## Chef

* Chef 12+

## Platforms

This cookbook is tested against:

* Ubuntu 14.04
* Ubuntu 15.04

...but it might work on other platforms.

# Usage

Include `recipe[drone::default]` in your run list.

# Attributes

These attributes are under the `node['drone']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
config | Hash of configuration options | Hash | See Configuration section below

# Configuration

The configuration in Drone 0.4.0 changed from TOML to BASH RC file.

The minimum required attribute is to set following tokens for your "remote" driver (gitlab, github, etc..)

* `node['drone']['config']['oauth_client']`
* `node['drone']['config']['oauth_secret']`

See the drone documentations and `attributes/default.rb` for more options.

## Docker

See `attributes/docker.rb` for more options.

# Recipes

* `recipe[default]` Installs/Configures Drone
* `recipe[docker]`  Installs/Configures Docker
