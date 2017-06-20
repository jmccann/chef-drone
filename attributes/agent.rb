default['drone']['agent']['config']['drone_server'] = 'ws://localhost/ws/broker'
default['drone']['agent']['vault']['items'] = %w(drone_secret)
default['drone']['agent']['volumes'] = ['/var/run/docker.sock:/var/run/docker.sock']
