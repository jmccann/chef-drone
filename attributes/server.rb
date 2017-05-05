default['drone']['server']['port'] = 80
default['drone']['server']['volumes'] = ['/var/lib/drone:/var/lib/drone', '/var/run/docker.sock:/var/run/docker.sock']

# database configuration
#
default['drone']['server']['config']['drone_database_driver'] = 'sqlite3'
default['drone']['server']['config']['drone_database_config'] = '/var/lib/drone/drone.sqlite'
