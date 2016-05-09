module ChefDrone
  # Methods for generating drone container ENV from node attributes
  module Env
    def drone_env
      node['drone']['config'].map { |k, v| "#{k.upcase}=#{v}" }
    end
  end
end

Chef::Recipe.send(:include, ChefDrone::Env)
DockerCookbook::DockerContainer.send(:include, ChefDrone::Env)
