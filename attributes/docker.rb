
# NOTE, assuming to switch from default['drone']['docker_*'] to default['docker'][....]

default['drone']['docker']['version'] = '1.8.3'
default['drone']['docker']['storage_driver'] = 'aufs'
default['drone']['docker']['hosts'] = ['unix:///var/run/docker.sock']

default['drone']['docker']['tls'] = false
default['drone']['docker']['tls_verify']  = false
default['drone']['docker']['tls_ca_crt']  = nil
default['drone']['docker']['tls_server_crt']  = nil
default['drone']['docker']['tls_server_key']  = nil
default['drone']['docker']['tls_client_crt']  = nil
default['drone']['docker']['tls_client_key']  = nil
