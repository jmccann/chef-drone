include_recipe 'chef-vault::default'

docker_image 'agent' do
  repo node['drone']['agent']['repo']
  tag node['drone']['version']
end

docker_container 'agent' do
  repo node['drone']['agent']['repo']
  tag node['drone']['version']
  env agent_env
  volumes node['drone']['agent']['volumes']
  network_mode node['drone']['agent']['network_mode'] if node['drone']['agent']['network_mode']
  restart_policy 'always'
  sensitive true

  if node['drone']['docker']
    node['drone']['docker'].each do |k, v|
      send(k, v)
    end
  end
end
