include_recipe "docker"

include_recipe "drone::_#{node['drone']['droned_opts']['driver']}"

remote_file node['drone']['temp_file'] do
  source node['drone']['package_url']
  action :create_if_missing
end

dpkg_package "drone" do
  source node['drone']['temp_file']
  action :install
end

droned_opts = ''
node['drone']['droned_opts'].each do |option, value|
  droned_opts << "--#{option}=#{value} "
end

template node['drone']['config_file'] do
  source 'drone.conf.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables(
     droned_opts: droned_opts
  )
  notifies :restart, 'service[drone]', :delayed
end

service "drone" do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
end
