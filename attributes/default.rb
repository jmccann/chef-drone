default['drone']['repo'] = 'drone/drone'
default['drone']['version'] = '0.4.2'
default['drone']['vault']['bag'] = 'vault_drone'
default['drone']['disable_repo_activation'] = false
default['drone']['repo_activation_org_whitelist'] = []
default['drone']['server']['port'] = 80
default['drone']['server']['volumes'] = ['/var/lib/drone:/var/lib/drone', '/var/run/docker.sock:/var/run/docker.sock']

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
