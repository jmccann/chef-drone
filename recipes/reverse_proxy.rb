include_recipe 'drone::default'
include_recipe 'drone::_nginx'

# Change host port to bind to so webserver can start on port 80
resources('docker_container[drone]').port '8000:8000'
