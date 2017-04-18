include_recipe 'chef-vault::default'
include_recipe 'drone::_docker'

docker_image 'agent' do
  repo node['drone']['repo']
  tag node['drone']['version']
end

docker_container 'agent' do
  repo node['drone']['repo']
  tag node['drone']['version']
  command 'agent'
  env agent_env
  volumes ['/var/run/docker.sock:/var/run/docker.sock']
  restart_policy 'always'
  detach true
  log_driver node['drone']['docker']['log_driver'] unless node['drone']['docker']['log_driver'].nil?
  log_opts node['drone']['docker']['log_opts']
  sensitive true
end
