package 'drone' do
  source node['drone']['package_url'] if node['drone']['package_url']
  version node['drone']['package_version'] if node['drone']['package_version']
end
