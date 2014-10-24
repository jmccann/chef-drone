template 'drone.conf' do
  source 'drone.conf.erb'
  path node['drone']['config_file']
  mode 0644
  owner 'root'
  group 'root'
  variables(
     droned_opts: node['drone']['droned_opts'],
     drone_tmp:   node['drone']['drone_tmp']
  )
end

service 'drone' do
  supports status: true, restart: true
  action [:enable, :start]
  subscribes :restart, 'drone.conf', :immediately
end
