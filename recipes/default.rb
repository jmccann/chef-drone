directory '/var/lib/drone'

include_recipe 'chef-vault::default'
include_recipe 'drone::_docker'

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
  network_mode node['drone']['server']['network_mode']
  restart_policy 'always'
  log_driver node['drone']['docker']['log_driver'] if node['drone']['docker']['log_driver']
  log_opts node['drone']['docker']['log_opts']
  sensitive true
end
