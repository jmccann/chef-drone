default['drone']['install_method'] = 'container'

# package
default['drone']['package_url'] = 'http://downloads.drone.io/0.4.0/drone.deb'
default['drone']['temp_file'] = '/tmp/drone.deb'
default['drone']['drone_tmp'] = '/tmp/drone'
default['drone']['install_docker'] = false

# init script
#
default['drone']['init_file'] = '/etc/init/drone.conf'
default['drone']['service_options'] = '' # '-debug -gitlab.skip-cert-check=true'

# dronerc
#
default['drone']['dronerc'] = '/etc/drone/dronerc'

# server & certs
#
#
default['drone']['server_address'] = ':80'
default['drone']['server_crt'] = ''
default['drone']['server_key'] = ''

# database configuration
#
default['drone']['config']['database_driver'] = 'sqlite3'
default['drone']['config']['database_config'] = '/var/lib/drone/drone.sqlite'

# remote configuration
#
default['drone']['config']['remote_driver'] = 'github'
default['drone']['config']['remote_config'] = 'https://github.com?client_id=${CLIENT}&client_secret=${SECRET}'

# docker configuration
default['drone']['config']['docker_host_1'] = 'unix:///var/run/docker.sock'
default['drone']['config']['docker_host_2'] = 'unix:///var/run/docker.sock'

# plugin configuration
#
default['drone']['config']['plugin_filter'] = 'plugins/*'
