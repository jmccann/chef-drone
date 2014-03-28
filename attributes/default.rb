default['drone']['package_url'] = "http://downloads.drone.io/latest/drone.deb"
default['drone']['temp_file'] = "/tmp/drone.deb"
default['drone']['config_file'] = '/etc/init/drone.conf'
default['drone']['droned_opts']['port'] = ':80'

default['drone']['droned_opts']['driver'] = 'sqlite3'

case node['drone']['droned_opts']['driver']
when 'sqlite3'
  default['drone']['droned_opts']['datasource'] = 'drone.sqlite'
when 'mysql' # not supported in drone ... yet.
  default['drone']['mysql']['install']  = true
  default['drone']['mysql']['host']     = 'localhost'
  default['drone']['mysql']['port']     = 3306
  default['drone']['mysql']['database'] = 'drone'
  default['drone']['mysql']['username'] = 'drone'
  default['drone']['mysql']['password'] = 'drone'
  dsn = node['drone']['mysql']['username'].clone
  dsn << ":#{node['drone']['mysql']['password']}"
  dsn << "@tcp(#{node['drone']['mysql']['host']}"
  dsn << ":#{node['drone']['mysql']['port']})"
  dsn << "/#{node['drone']['mysql']['database']}"
  dsn << '?parseTime=true'
  default['drone']['droned_opts']['datasource'] = dsn
end
