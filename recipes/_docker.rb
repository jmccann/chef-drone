include_recipe 'drone::_gen_docker_certs' if node['drone']['generate_certs']

# Required for aufs
package "linux-image-extra-#{node['kernel']['release']}" do
  only_if { node['drone']['docker']['storage_driver'] == 'aufs' }
end

docker_service 'default' do
  version node['drone']['docker']['version']
  install_method 'binary'
  retries 1
  retry_delay 20
  host node['drone']['docker']['hosts']
  storage_driver node['drone']['docker']['storage_driver']
  tls node['drone']['docker']['tls'] if node['drone']['docker']['tls'] && node['drone']['docker']['tls_server_key']
  tls_verify node['drone']['docker']['tls_verify'] if node['drone']['docker']['tls'] && node['drone']['docker']['tls_server_key']
  tls_ca_cert node['drone']['docker']['tls_ca_crt'] if node['drone']['docker']['tls'] && node['drone']['docker']['tls_server_key']
  tls_server_cert node['drone']['docker']['tls_server_crt'] if node['drone']['docker']['tls'] && node['drone']['docker']['tls_server_key']
  tls_server_key node['drone']['docker']['tls_server_key'] if node['drone']['docker']['tls'] && node['drone']['docker']['tls_server_key']
  tls_client_cert node['drone']['docker']['tls_client_crt'] if node['drone']['docker']['tls'] && node['drone']['docker']['tls_server_key']
  tls_client_key node['drone']['docker']['tls_client_key'] if node['drone']['docker']['tls'] && node['drone']['docker']['tls_server_key']
  action [:create, :start]
end
