class Chef::Provider::DroneConfig < Chef::Provider::LWRPBase
  provides :drone_config

  action :create do
    include_recipe 'chef-sugar::default'
    require_chef_gem 'toml'

    file @new_resource.config_filepath do
      mode '0644'
      content ::TOML::Generator.new(@new_resource.to_toml).body
      notifies :restart, "drone_service[#{@new_resource.instance_name}]", :delayed
    end
  end

  action :delete do
    file @new_resource.config_filepath do
      action :delete
    end
  end

  def whyrun_supported?
    true
  end

  use_inline_resources if defined?(use_inline_resources)
end
