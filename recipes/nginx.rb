node.set['nginx']['default_site_enabled'] = false

include_recipe "nginx"

template "/etc/nginx/sites-available/drone" do
  source node['drone']['nginx']['template']
  cookbook node['drone']['nginx']['template_cookbook']
  notifies :reload, "service[nginx]"
  variables(
    :server_name    => node['drone']['nginx']['hostname'],
    :server_aliases => node['drone']['nginx']['aliases'],
    :listen_address => node['drone']['nginx']['listen'],
    :listen_port    => node['drone']['nginx']['port'],
    :drone_port     => node['drone']['port'],
    :drone_address  => node['drone']['address']
  )
end

nginx_site "drone"