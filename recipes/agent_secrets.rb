include_recipe 'chef-vault::default'
include_recipe 'drone::agent'

new_env = drone_env

%w(drone_token).each do |item|
  override_secret 'docker_container[agent]', new_env, item
end
