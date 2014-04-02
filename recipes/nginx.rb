node.set['nginx']['default_site_enabled'] = false

include_recipe 'nginx'

if node['drone']['nginx']['enable_ssl']
  template = node['drone']['nginx']['ssl_template']

  file "/etc/ssl/#{node['drone']['nginx']['hostname']}.key" do
    owner   'root'
    group   'root'
    mode    '0600'
    content node['drone']['nginx']['ssl_key']
    action  :create
  end

  file "/etc/ssl/#{node['drone']['nginx']['hostname']}.cert" do
    owner   'root'
    group   'root'
    mode    '0600'
    content node['drone']['nginx']['ssl_cert']
    action  :create
  end

else
  template = node['drone']['nginx']['template']
end

template '/etc/nginx/sites-available/drone' do
  source template
  cookbook node['drone']['nginx']['template_cookbook']
  notifies :reload, "service[nginx]"
  variables(
    server_name:        node['drone']['nginx']['hostname'],
    server_aliases:     node['drone']['nginx']['aliases'],
    listen_address:     node['drone']['nginx']['listen'],
    listen_port:        node['drone']['nginx']['port'],
    ssl_listen_address: node['drone']['nginx']['ssl_listen'],
    ssl_listen_port:    node['drone']['nginx']['ssl_port'],
    drone_port:         node['drone']['port'],
    drone_address:      node['drone']['address'],
    ssl_key:            "/etc/ssl/#{node['drone']['nginx']['hostname']}.key",
    ssl_cert:           "/etc/ssl/#{node['drone']['nginx']['hostname']}.cert"
  )
end

nginx_site 'drone'
