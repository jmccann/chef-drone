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
  port "#{node['drone']['server']['port']}:8000"
  env drone_env
  volumes node['drone']['server']['volumes']
  restart_policy 'always'
  log_driver node['drone']['docker']['log_driver'] unless node['drone']['docker']['log_driver'].nil?
  log_opts node['drone']['docker']['log_opts']
  sensitive true
end
