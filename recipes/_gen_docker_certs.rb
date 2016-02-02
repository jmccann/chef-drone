# drone, docker servers + ca
server = ssl_certificate 'self-signed-server' do
  namespace node['fqdn']
  # NOTE, there is no longer :restart action on docker_service
  # notifies :restart, 'docker_service[default]', :delayed
  # notifies :restart, 'service[drone]', :delayed
end

node.set[node['drone']['server_crt']] = server.cert_path
node.set[node['drone']['server_key']] = server.key_path

# docker client
client = ssl_certificate 'self-signed-docker-client' do
  namespace "#{node['hostname']}-docker-client"
  ca_cert_path server.ca_cert_path
  ca_key_path server.ca_key_path
  # NOTE, there is no longer :restart action on docker_service
  # notifies :restart, 'docker_service[default]', :delayed
end

node.set['drone']['docker']['tls_ca_crt'] || server.ca_cert_path
node.set['drone']['docker']['tls_server_crt'] || server.cert_path
node.set['drone']['docker']['tls_server_key'] || server.key_path
node.set['drone']['docker']['tls_client_crt'] || client.cert_path
node.set['drone']['docker']['tls_client_key'] || client.key_path
