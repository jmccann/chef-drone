# Required for aufs
package "linux-image-extra-#{node['kernel']['release']}" do
  only_if { node['drone']['docker']['storage_driver'] == 'aufs' }
end

# Required for devicemapper storage driver
# https://github.com/docker/docker/issues/22381#issuecomment-215342747
docker_installation_script 'default' do
  only_if { ['centos', 'redhat', 'amazon', 'scientific', 'oracle', 'fedora'].include?(node['platform']) }
end

docker_installation_tarball 'default' do
  checksum node['drone']['docker']['checksum'] unless node['drone']['docker']['checksum'].nil?
  version node['drone']['docker']['version'] unless node['drone']['docker']['version'].nil?
  only_if { ['debian', 'ubuntu'].include?(node['platform']) }
end

docker_service_manager 'default' do
  host node['drone']['docker']['hosts']
  log_level node['drone']['docker']['daemon']['log_level'].to_sym
  retries 1
  retry_delay 20
  storage_driver node['drone']['docker']['storage_driver']
end
