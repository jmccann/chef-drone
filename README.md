# Drone cookbook

[![Build Status](https://travis-ci.org/justincampbell/chef-drone.png?branch=master)](https://travis-ci.org/justincampbell/chef-drone)

Installs [Drone](https://github.com/drone/drone), a CI server built on [Docker](https://www.docker.io).

# Requirements

## Chef

* Chef 11+

## Platforms

This cookbook is tested against:

* Ubuntu 12.04
* Ubuntu 13.10
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

The configuration is defined as a hash, and converted to TOML format for drone's configuration.

The default configuration is minimal:

	default['drone']['config'] = {
	  'server' => {
	    'port' => ':80',
	  },
	  'database' => {
	    'driver' => 'sqlite3',
	    'datasource' => '/var/lib/drone/drone.sqlite'
	  }
	}

*Note:* It is recommended that you link at least one source control system to drone, to enable the capability to login.

The following example configuration enables Drone to authenticate off a Github Enterprise installation:

	default['drone']['config'] = {
	  'server' => {
	    'port' => ':80',
	  },
	  'database' => {
	    'driver' => 'sqlite3',
	    'datasource' => '/var/lib/drone/drone.sqlite'
	  },
	  'github_enterprise' => {
	    'client' => 'YOURCLIENT',
	    'secret' => 'YOURSECRET',
	    'api' => 'http://github.mycompany.com/api/v3/',
	    'url' => 'http://github.mycompany.com',
	    'private_mode' => true,
	    'open' => true
	  }
	}

There are many more configuration options that you can specify, and the complete config is shown below:

	default['drone']['config'] = {
	  'server' => {
	    'port' => ':80',
	    'ssl' => {
	      'key' => '',
	      'cert' => ''
	    },
	    'assets' => {
	      'folder' => ''
	    },
	    'session' => {
	      'secret' => '',
	      'expires' => ''
	    }
	  },
	  'session' => {
	    'secret' => '',
	    'expires' => ''
	  },
	  'database' => {
	    'driver' => 'sqlite3',
	    'datasource' => '/var/lib/drone/drone.sqlite'
	  },
	  'github' => {
	    'client' => '',
	    'secret' => '',
	    'orgs' => [],
	    'open' => false
	  },
	  'github_enterprise' => {
	    'client' => '',
	    'secret' => '',
	    'api' => '',
	    'url' => '',
	    'private_mode' => false,
	    'open' => false
	  },
	  'bitbucket' => {
	    'client' => '',
	    'secret' => '',
	    'open' => false
	  },
	  'gitlab' => {
	    'url' => '',
	    'client' => '',
	    'secret' => '',
	    'skip_verify' => false,
	    'open' => false
	  },
	  'gogs' => {
	    'url' => '',
	    'secret' => '',
	    'open' => false
	  },
	  'smtp' => {
	    'host' => '',
	    'port' => '',
	    'from' => '',
	    'user' => '',
	    'pass' => ''
	  },
	  'docker' => {
	    'cert' => '',
	    'key' => ''
	  },
	  'worker' => {
	    'nodes' => [
	      'unix:///var/run/docker.sock'
	    ]
	  }
	}

# Recipes

* `recipe[drone]` Installs/Configures Drone
