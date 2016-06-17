module ChefDrone
  # Methods for generating drone container ENV from node attributes
  module Env
    def drone_env
      node['drone']['config'].map { |k, v| "#{k.upcase}=#{v}" }
    end

    def agent_env
      node['drone']['agent']['config'].map { |k, v| "#{k.upcase}=#{v}" }
    end

    #
    # Override attribute secrets if in Vault or DataBag
    #
    def override_secret(res_name, current_env, item)
      return unless secret_exist? item

      secret = chef_vault_item(node['drone']['vault']['bag'], item)[item]
      new_env = current_env.delete_if { |env| env =~ /#{item.upcase}=/ }.push("#{item.upcase}=#{secret}")
      resources(res_name).env new_env
      new_env
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
