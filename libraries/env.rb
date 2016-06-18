module ChefDrone
  # Methods for generating drone container ENV from node attributes
  module Env
    def drone_env
      env = node['drone']['config'].map { |k, v| "#{k.upcase}=#{v}" }
      %w(drone_agent_secret drone_github_secret database_config).each do |item|
        env = override_secret env, item
      end
      env
    end

    def agent_env
      env = node['drone']['agent']['config'].map { |k, v| "#{k.upcase}=#{v}" }
      %w(drone_token).each do |item|
        env = override_secret env, item
      end
      env
    end

    #
    # Override attribute secrets if in Vault or DataBag
    #
    def override_secret(current_env, item)
      return current_env unless secret_exist? item

      secret = chef_vault_item(node['drone']['vault']['bag'], item)[item]
      current_env.delete_if { |env| env =~ /#{item.upcase}=/ }.push("#{item.upcase}=#{secret}")
    end

    #
    # Check if secret exists in Vault or DataBag
    #
    def secret_exist?(item)
      Chef::DataBag.list.keys.include?(node['drone']['vault']['bag']) && Chef::DataBag.load(node['drone']['vault']['bag']).keys.include?(item)
    end
  end
end

Chef::Recipe.send(:include, ChefDrone::Env)
DockerCookbook::DockerContainer.send(:include, ChefDrone::Env)
