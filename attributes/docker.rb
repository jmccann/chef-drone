default['drone']['docker']['version'] = nil
default['drone']['docker']['hosts'] = ['unix:///var/run/docker.sock']
default['drone']['docker']['log_driver'] = nil
default['drone']['docker']['log_opts'] = nil
default['drone']['docker']['daemon']['log_level'] = 'info'

# select storage drive based on docker compatibility matrix
# https://success.docker.com/Get_Help/Compatibility_Matrix_and_Maintenance_Lifecycle
case node['platform']
when 'debian', 'ubuntu'
  default['drone']['docker']['storage_driver'] = 'aufs'
when 'centos', 'redhat', 'amazon', 'scientific', 'oracle', 'fedora'
  default['drone']['docker']['storage_driver'] = 'devicemapper'
end
