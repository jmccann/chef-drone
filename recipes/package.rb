remote_file node['drone']['temp_file'] do
  source node['drone']['package_url']
  action :create_if_missing
end

dpkg_package 'drone' do
  source node['drone']['temp_file']
  action :install
end

template 'dronerc' do
  source 'dronerc.erb'
  path node['drone']['dronerc']
  mode 0644
  owner 'root'
  group 'root'
  notifies :restart, 'service[drone]', :delayed
end

template 'drone.conf' do
  source 'drone.init.erb'
  path node['drone']['init_file']
  mode 0644
  owner 'root'
  group 'root'
  notifies :restart, 'service[drone]', :delayed
end

service 'drone' do
  retries 3
  retry_delay 20
  provider Chef::Provider::Service::Upstart
  supports status: true, restart: true
  action [:enable, :start]
  restart_command 'service drone restart'
  subscribes :restart, 'template[drone.conf]', :delayed
  subscribes :restart, "file[#{node['drone']['dronerc']}]", :delayed
end
