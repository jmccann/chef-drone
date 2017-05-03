# gogs [![Build Status](https://travis-ci.org/EdHurtig/chef-gogs.svg)](https://travis-ci.org/EdHurtig/chef-gogs)

Installs gogs (Go Git Service), An open source Git Service. 

This cookbook installs gogs on port 8080 with sqllite3 by default. It skips the installer
meaning that everything is set to go; however, you will need to create an admin account
on your own.  Do this by just going to the web ui and filling out the form or by inserting into 
the database.  LWRP for that to come at some point.

# Requirements

* `apt` cookbook
* `systemd` cookbook
* `ark` cookbook
* `chef-sugar` cookbook


# Attributes

### Install Attributes

* `node['gogs']['install_dir']` default: `'/opt'`

The path to install gogs to, note that there will be a `gogs` subfolder created where everything will live.
By default the executable and configuration lives in `/opt/gogs/`.

* `node['gogs']['version']` default `'0.6.1'`

The Release version to install.  See https://github.com/gogits/gogs/releases

### Config Attributes

The `node['gogs']['config']` tree gets parsed into the gogs [app.ini](https://github.com/gogits/gogs/blob/master/conf/app.ini).  
Note that the attributes are split into sections then into their individual settings.

For Documentation on what each setting does please refer to the [app.ini](https://github.com/gogits/gogs/blob/master/conf/app.ini)

An excerpt of [attributes/default.rb](https://github.com/EdHurtig/chef-gogs/blob/master/attributes/default.rb)
to give you an idea of how these options work: 

```ruby
default['gogs']['config']['global']['APP_NAME'] = 'Gogs: Go Git Service'
default['gogs']['config']['global']['RUN_USER'] = 'git'
default['gogs']['config']['global']['RUN_MODE'] = 'prod'

default['gogs']['config']['repository']['ROOT'] = '/ops/gogs/repos'
default['gogs']['config']['repository']['SCRIPT_TYPE'] = 'bash'

default['gogs']['config']['server']['PROTOCOL'] = 'http'
default['gogs']['config']['server']['DOMAIN'] = 'localhost'
default['gogs']['config']['server']['ROOT_URL'] = '%(PROTOCOL)s://%(DOMAIN)s:%(HTTP_PORT)s/'
default['gogs']['config']['server']['HTTP_ADDR'] = '0.0.0.0'
default['gogs']['config']['server']['HTTP_PORT'] = 8080
```

# Recipes

## default

This recipe installs and configures gogs

1. Set up & updates apt using `apt::default`
2. Installs Git and Supervisord
3. Downloads and installs gogs from Github
4. Configures gogs according to `node['gogs']['config']`


# Usage

Include this recipe in a wrapper cookbook:

```
depends 'gogs', '~> 1.0'
```

```
include_recipe 'gogs::default'
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests with `kitchen test`, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Author:: Eddie Hurtig (eddie@hurtigtechnologies.com)
