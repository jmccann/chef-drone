
# NOTE, assuming to switch from default['drone']['docker_*'] to default['docker'][....]

default['drone']['docker']['version'] = '1.9.1'
default['drone']['docker']['hosts'] = ['unix:///var/run/docker.sock']
default['drone']['docker']['log_driver'] = nil
default['drone']['docker']['log_opts'] = nil
# select storage drive based on docker compatibility matrix
# https://success.docker.com/Get_Help/Compatibility_Matrix_and_Maintenance_Lifecycle
case node['platform']
when 'debian', 'ubuntu'
  default['drone']['docker']['storage_driver'] = 'aufs'
when 'centos', 'redhat', 'amazon', 'scientific', 'oracle', 'fedora'
  default['drone']['docker']['storage_driver'] = 'devicemapper'
end

default['drone']['docker']['tls'] = false
default['drone']['docker']['tls_verify']  = false
default['drone']['docker']['tls_ca_crt']  = nil
default['drone']['docker']['tls_server_crt']  = nil
default['drone']['docker']['tls_server_key']  = nil
default['drone']['docker']['tls_client_crt']  = nil
default['drone']['docker']['tls_client_key']  = nil
