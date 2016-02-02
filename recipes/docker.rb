include_recipe 'drone::_gen_docker_certs' if node['drone']['generate_certs']

docker_service 'default' do
  version node['drone']['docker_version']
  retries 1
  retry_delay 20
  host node['drone']['docker_hosts']
  storage_driver node['drone']['docker_storage_driver']
  tls node['drone']['docker_tls'] if node['drone']['docker_tls'] && node['drone']['docker_tls_server_key']
  tls_verify node['drone']['docker_tls_verify'] if node['drone']['docker_tls'] && node['drone']['docker_tls_server_key']
  tls_ca_cert node['drone']['docker_tls_ca_crt'] if node['drone']['docker_tls'] && node['drone']['docker_tls_server_key']
  tls_server_cert node['drone']['docker_tls_server_crt'] if node['drone']['docker_tls'] && node['drone']['docker_tls_server_key']
  tls_server_key node['drone']['docker_tls_server_key'] if node['drone']['docker_tls'] && node['drone']['docker_tls_server_key']
  tls_client_cert node['drone']['docker_tls_client_crt'] if node['drone']['docker_tls'] && node['drone']['docker_tls_server_key']
  tls_client_key node['drone']['docker_tls_client_key'] if node['drone']['docker_tls'] && node['drone']['docker_tls_server_key']
  action [:create, :start]
end
