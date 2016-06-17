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

# Set secrets from chef-vault if it exists
new_env = drone_env
%w(drone_token).each do |item|
  override_secret 'docker_container[agent]', new_env, item
end
