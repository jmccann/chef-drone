directory '/var/lib/drone'

include_recipe "drone::container" unless node['drone']['install_method'] == 'package' # Default method of install
