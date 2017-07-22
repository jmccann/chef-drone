default['drone']['server']['port'] = ['80:8000', '9000:9000']
default['drone']['server']['repo'] = 'drone/drone'
default['drone']['server']['vault']['items'] = %w(database_config drone_database_datasource drone_github_client drone_github_secret drone_license drone_secret)
default['drone']['server']['volumes'] = ['/var/lib/drone:/var/lib/drone', '/var/run/docker.sock:/var/run/docker.sock']

# server configuration
#
default['drone']['server']['config']['drone_database_driver'] = 'sqlite3'
default['drone']['server']['config']['drone_database_config'] = '/var/lib/drone/drone.sqlite'
