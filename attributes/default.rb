default['drone']['package_url'] = "http://downloads.drone.io/latest/drone.deb"
default['drone']['temp_file']   = "/tmp/drone.deb"
default['drone']['config_file'] = '/etc/init/drone.conf'
default['drone']['address']     = '0.0.0.0'
default['drone']['port']        = '80'
default['drone']['droned_opts'] = "--port=#{node['drone']['address']}:#{node['drone']['port']}"
default['drone']['drone_tmp']   = '/tmp/drone'
