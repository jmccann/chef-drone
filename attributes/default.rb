default['drone']['package_url'] = 'http://downloads.drone.io/master/drone.deb'
default['drone']['temp_file'] = '/tmp/drone.deb'
default['drone']['config_file'] = '/etc/init/drone.conf'
default['drone']['droned_opts'] = ''
default['drone']['drone_tmp'] = '/tmp/drone'
default['drone']['toml_config_file'] = '/etc/drone/drone.toml'
default['drone']['config'] = {
  'server' => {
    'port' => ':80',
  },
  'database' => {
    'driver' => 'sqlite3',
    'datasource' => '/var/lib/drone/drone.sqlite'
  },
  'registration' => {
    'open' => true
  }
}
