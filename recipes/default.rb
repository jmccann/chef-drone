drone_config '/etc/drone/drone.toml' do
  notifies :restart, "drone_service[#{node['drone']['service_name']}]"
end

drone_service node['drone']['service_name'] do
  action [:create, :start]
end
