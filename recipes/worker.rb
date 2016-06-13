# Set default docker hosts to socket and listening on IP for drone master to connect
node.default['drone']['docker']['hosts'] = ['unix:///var/run/docker.sock', "tcp://#{node['ipaddress']}:2376"]

# Install docker
include_recipe 'drone::_docker'
