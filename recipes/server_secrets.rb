include_recipe 'chef-vault::default'
include_recipe 'drone::default'

new_env = drone_env

%w(drone_agent_secret drone_github_secret).each do |item|
  new_env = override_secret 'docker_container[drone]', new_env, item
end
