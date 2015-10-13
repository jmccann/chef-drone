
# drone, docker servers + ca
server = ssl_certificate 'self-signed-server' do
  namespace node['fqdn']
  notifies :restart, 'docker_service[default]', :delayed
  notifies :restart, 'service[drone]', :delayed
  only_if node['drone']['generate_certs'].to_s
end

if node['drone']['generate_certs']
  node.set[node['drone']['server_crt']] = server.cert_path
  node.set[node['drone']['server_key']] = server.key_path
end

# docker client
client = ssl_certificate 'self-signed-docker-client' do
  namespace "#{node['hostname']}-docker-client"
  ca_cert_path server.ca_cert_path
  ca_key_path server.ca_key_path
  notifies :restart, 'docker_service[default]', :delayed
  only_if node['drone']['generate_certs'].to_s
end

docker_service 'default' do
  host ['unix:///var/run/docker.sock', "tcp://#{node['ipaddress']}:4242"]
  tls node['drone']['docker_tls']
  tls_verify node['drone']['docker_tls_verify']
  tls_ca_cert node['drone']['docker_tls_ca_crt'] || server.ca_cert_path if node['drone']['generate_certs']
  tls_server_cert node['drone']['docker_tls_server_crt'] || server.cert_path if node['drone']['generate_certs']
  tls_server_key node['drone']['docker_tls_server_key'] || server.key_path if node['drone']['generate_certs']
  tls_client_cert node['drone']['docker_tls_client_crt'] || client.cert_path if node['drone']['generate_certs']
  tls_client_key node['drone']['docker_tls_client_key'] || client.key_path if node['drone']['generate_certs']
  # provider Chef::Provider::DockerService::Systemd
  action [:create, :start]
end
