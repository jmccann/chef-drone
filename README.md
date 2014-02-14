# Drone cookbook

Installs [Drone](https://github.com/drone/drone), a CI server built on [Docker](https://www.docker.io).

# Requirements

## Chef

* Chef 11+

## Platforms

* Ubuntu 13.04

# Usage

Include `recipe[drone]` in your run list.

# Attributes

These attributes are under the `node['drone']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
package_url | URL of the Drone package to download and install | String | [http://downloads.drone.io/latest/drone.deb](http://downloads.drone.io/latest/drone.deb)
temp_file | Path to store the downloaded package | String | /tmp/drone.deb

# Recipes

* `recipe[drone]` Installs/Configures Drone
