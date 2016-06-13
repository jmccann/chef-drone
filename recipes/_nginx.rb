# Install/Configure nginx
include_recipe 'nginx::default'

# Override their template with our own
resources("template[#{node['nginx']['dir']}/sites-available/default]").cookbook 'drone'
resources("template[#{node['nginx']['dir']}/sites-available/default]").source 'nginx-default-site.erb'
