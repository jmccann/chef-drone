
# NOTE, assuming to switch from default['drone']['docker_*'] to default['docker'][....]

default['drone']['docker_version'] = '1.8.3'
default['drone']['docker_storage_driver'] = 'overlay'

default['drone']['docker_tls'] = false
default['drone']['docker_hosts'] = ['unix:///var/run/docker.sock']
default['drone']['docker_tls_verify']  = false
default['drone']['docker_tls_ca_crt']  = nil
default['drone']['docker_tls_server_crt']  = nil
default['drone']['docker_tls_server_key']  = nil
default['drone']['docker_tls_client_crt']  = nil
default['drone']['docker_tls_client_key']  = nil
