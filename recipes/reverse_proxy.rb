include_recipe 'drone::default'
include_recipe 'chef-vault::default'
include_recipe 'drone::_nginx'

ssl_certificate 'drone' do
  common_name 'target.com'
  source 'chef-vault'
  bag node['drone']['vault']['bag']
  key_item 'certs'
  key_item_key 'key'
  cert_item 'certs'
  cert_item_key 'cert'
end

# Change host port to bind to so webserver can start on port 80
resources('docker_container[drone]').port '8000:8000'
