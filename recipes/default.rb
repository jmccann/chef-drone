include_recipe "docker"

remote_file node['drone']['temp_file'] do
  source node['drone']['package_url']
  action :create_if_missing
end

dpkg_package "drone" do
  source node['drone']['temp_file']
  action :install
end

service "drone" do
  action :start
end
