module ChefDrone
  module Env
    def drone_env
      env = []
      env << "DATABASE_DRIVER=#{node['drone']['database_driver']}"
      env << "DATABASE_CONFIG=#{node['drone']['database_config']}"
      env << "REMOTE_DRIVER=#{node['drone']['remote_driver']}"
      env << "REMOTE_CONFIG=#{node['drone']['remote_config']}"
      node['drone']['docker_hosts'].each_with_index do |host, idx|
        env << "DOCKER_HOST_#{idx + 1}=#{host}"
      end
      env << "PLUGIN_FILTER=#{node['drone']['plugin_filter']}"
      env
    end
  end
end

Chef::Recipe.send(:include, ChefDrone::Env)
DockerCookbook::DockerContainer.send(:include, ChefDrone::Env)
