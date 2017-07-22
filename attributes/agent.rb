default['drone']['agent']['config']['drone_server'] = 'localhost:9000'
default['drone']['agent']['repo'] = 'drone/agent'
default['drone']['agent']['vault']['items'] = %w(drone_secret)
default['drone']['agent']['volumes'] = ['/var/run/docker.sock:/var/run/docker.sock']
