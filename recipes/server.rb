directory '/var/lib/drone'

include_recipe 'chef-vault::default'

docker_image 'drone' do
  repo node['drone']['repo']
  tag node['drone']['version']
end

docker_container 'drone' do
  repo node['drone']['repo']
  tag node['drone']['version']
  port node['drone']['server']['port']
  env drone_env
  volumes node['drone']['server']['volumes']
  network_mode node['drone']['server']['network_mode'] if node['drone']['server']['network_mode']
  restart_policy 'always'
  sensitive true

  if node['drone']['docker']
    node['drone']['docker'].each do |k, v|
      send(k, v)
    end
  end
end
