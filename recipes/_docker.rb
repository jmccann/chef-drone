docker_installation_package 'default' do
  version node['drone']['docker']['version'] if node['drone']['docker']['version']
end

docker_service_manager 'default' do
  host node['drone']['docker']['hosts']
  log_level node['drone']['docker']['daemon']['log_level'].to_sym
  retries 1
  retry_delay 20
  storage_driver node['drone']['docker']['storage_driver']
end

execute 'restart docker' do
  command 'exit 0'
  notifies :restart, 'docker_service_manager[default]', :immediate
  not_if "docker info | grep 'Storage Driver: #{node['drone']['docker']['storage_driver']}'"
end
