# include_recipe 'drone::agent'

ruby_block 'set drone token' do
  block do
    cmd = Mixlib::ShellOut.new('docker logs drone')
    cmd.run_command
    token = cmd.stderr.lines.grep(/token/).first.split('"')[3].split[5]

    new_env = resources('docker_container[agent]').env
    new_env = new_env.delete_if { |env| env =~ /DRONE_TOKEN=/ }.push("DRONE_TOKEN=#{token}")
    # resources('docker_container[agent]').env new_env

    r = run_context.resource_collection.find(docker_container: 'agent')
    # Update the content attribute
    r.env new_env

    node.set['drone']['agent']['config']['drone_token'] = token
  end
end
