directory '/var/lib/drone'

include_recipe 'chef-vault::default'
include_recipe 'drone::_docker'

docker_image 'drone' do
  repo 'drone/drone'
  tag node['drone']['version']
end

docker_container 'drone' do
  repo 'drone/drone'
  tag node['drone']['version']
  port '80:8000'
  env drone_env
  volumes ['/var/lib/drone:/var/lib/drone', '/var/run/docker.sock:/var/run/docker.sock']
  restart_policy 'always'
  sensitive true
end

new_env = drone_env
%w(drone_agent_secret drone_github_secret).each do |item|
  new_env = override_secret 'docker_container[drone]', new_env, item
end
