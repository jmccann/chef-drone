include_recipe "#{cookbook_name}::docker" if node['drone']['install_docker']

directory '/var/lib/drone'

include_recipe "drone::package" if node['drone']['install_method'] == 'package'
include_recipe "drone::container" unless node['drone']['install_method'] == 'package' # Default method of install
