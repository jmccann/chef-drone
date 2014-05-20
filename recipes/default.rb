include_recipe 'docker'

remote_file node['drone']['temp_file'] do
  source node['drone']['package_url']
  action :create_if_missing
end

dpkg_package 'drone' do
  source node['drone']['temp_file']
  action :install
end

template node['drone']['config_file'] do
  source 'drone.conf.erb'
  mode '0644'
  owner 'root'
  group 'root'
  variables(
     droned_opts: node['drone']['droned_opts'],
     drone_tmp:   node['drone']['drone_tmp']
  )
  notifies :restart, 'service[drone]', :delayed
  action :create
end

service 'drone' do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
end
