include_recipe 'chef-vault::default'
include_recipe 'drone::_docker'

docker_image 'agent' do
  repo 'drone/drone'
  tag node['drone']['version']
end

docker_container 'agent' do
  repo 'drone/drone'
  tag node['drone']['version']
  command 'agent'
  env agent_env
  volumes ['/var/run/docker.sock:/var/run/docker.sock']
  restart_policy 'always'
  detach true
  sensitive true
end
