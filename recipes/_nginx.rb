cert = ssl_certificate 'drone' do
  common_name 'target.com'
  source 'chef-vault'
  bag node['drone']['vault']['bag']
  key_item 'certs'
  key_item_key 'key'
  cert_item 'certs'
  cert_item_key 'cert'
end

# Install/Configure nginx
include_recipe 'chef_nginx::default'

# Override their template with our own
resources("template[#{node['nginx']['dir']}/sites-available/default]").cookbook 'drone'
resources("template[#{node['nginx']['dir']}/sites-available/default]").source 'nginx-default-site.erb'
resources("template[#{node['nginx']['dir']}/sites-available/default]").variables(
  cert: cert
)
