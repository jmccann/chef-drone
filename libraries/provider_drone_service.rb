class Chef::Provider::DroneService < Chef::Provider::LWRPBase
  provides :drone_service

  action :create do
    include_recipe 'docker::default'

    poise_service @new_resource.service_name do
      provider @new_resource.service_type
      action :create
    end
  end

  action :start do
    poise_service @new_resource.service_name do
      action :start
    end
  end

  action :stop do
    poise_service @new_resource.service_name do
      action :stop
    end
  end

  action :restart do
    poise_service @new_resource.service_name do
      action :restart
    end
  end

  action :purge do
    action_delete

    # For those wishing to completely wipe the system. I am not sure
    # in what use case this is good, maybe physical hardware?
    uninstall_package if @new_resource.install_method == 'package'
    uninstall_source if @new_resource.install_method == 'source'
  end

  action :delete do
    action_stop

    file @new_resource.config_filepath do
      action :delete
    end
  end

  def install_package
    package 'drone' do
      source node['drone']['remote_url'] if node['drone']['remote_url']
      version node['drone']['package_version'] if node['drone']['package_version']
    end
  end

  def uninstall_package
    package 'drone' do
      action :remove
    end
  end

  def install_source
    include_recipe 'golang::default'

    directory File.join(node['go']['gopath'], 'src/github.com/drone') do
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
  end

  def uninstall_source
    link File.join(node['drone']['install_dir'], 'drone') do
      to File.join(node['go']['gobin'], 'drone')
      action :delete
    end

    golang_package 'github.com/drone/drone' do
      action :uninstall
    end

    directory File.join(node['go']['gopath'], 'src/github.com/drone') do
      action :delete
    end
  end

  def whyrun_supported?
    true
  end

  use_inline_resources if defined?(use_inline_resources)
end
