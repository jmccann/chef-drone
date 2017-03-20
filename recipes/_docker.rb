include_recipe 'drone::_gen_docker_certs' if node['drone']['generate_certs']

# Required for aufs
package "linux-image-extra" do
  package_name "linux-image-extra-#{node['kernel']['release']}"
  only_if { node['drone']['docker']['storage_driver'] == 'aufs' }
end

# Required for devicemapper storage driver
# https://github.com/docker/docker/issues/22381#issuecomment-215342747
docker_installation_script 'default' do
  only_if { ['centos', 'redhat', 'amazon', 'scientific', 'oracle', 'fedora'].include?(node['platform']) }
end

docker_installation_tarball 'default' do
  version node['drone']['docker']['version'] if node['drone']['docker']['version']
  only_if { ['debian', 'ubuntu'].include?(node['platform']) }
end

docker_service_manager 'default' do
  host node['drone']['docker']['hosts']
  log_level node['drone']['docker']['daemon']['log_level'].to_sym
  retries 1
  retry_delay 20
  storage_driver node['drone']['docker']['storage_driver']
  tls node['drone']['docker']['tls'] if node['drone']['docker']['tls'] && node['drone']['docker']['tls_server_key']
  tls_verify node['drone']['docker']['tls_verify'] if node['drone']['docker']['tls'] && node['drone']['docker']['tls_server_key']
  tls_ca_cert node['drone']['docker']['tls_ca_crt'] if node['drone']['docker']['tls'] && node['drone']['docker']['tls_server_key']
  tls_server_cert node['drone']['docker']['tls_server_crt'] if node['drone']['docker']['tls'] && node['drone']['docker']['tls_server_key']
  tls_server_key node['drone']['docker']['tls_server_key'] if node['drone']['docker']['tls'] && node['drone']['docker']['tls_server_key']
  tls_client_cert node['drone']['docker']['tls_client_crt'] if node['drone']['docker']['tls'] && node['drone']['docker']['tls_server_key']
  tls_client_key node['drone']['docker']['tls_client_key'] if node['drone']['docker']['tls'] && node['drone']['docker']['tls_server_key']
end
