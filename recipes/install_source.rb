include_recipe 'golang::default'

directory File.join(node['go']['gopath'], 'src/github.com/drone') do
  owner 'root'
  group 'root'
  mode '00755'
  recursive true
end

git File.join(node['go']['gopath'], '/src/github.com/drone/drone') do
  repository node['drone']['git_url']
  reference node['drone']['git_ref']
  action :checkout
end

golang_package 'github.com/drone/drone' do
  action :install
end

link File.join(node['drone']['install_dir'], 'drone') do
  to File.join(node['go']['gobin'], 'drone')
end
