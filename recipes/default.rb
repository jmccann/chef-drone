include_recipe 'docker::default'

install_type = node['drone']['install_type']
include_recipe "drone::install_#{install_type}"

include_recipe 'drone::_service'
