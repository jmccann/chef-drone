cert = ssl_certificate 'drone' do
  source 'chef-vault'
  bag node['drone']['vault']['bag']
  key_item 'certs'
  key_item_key 'key'
  cert_item 'certs'
  cert_item_key 'cert'
end

# Install/Configure nginx
include_recipe 'chef_nginx::default'

node.default['nginx']['default_site_enabled'] = false

nginx_site 'default' do
  template 'drone.erb'
  variables cert: cert
end
