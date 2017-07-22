#
# Cookbook Name:: drone
# Spec:: agent
#

require 'spec_helper'

describe 'drone::agent' do
  context 'When all attributes are default, on ubuntu, getting secrets from attribtues' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node, _server|
        node.default['drone']['agent']['config']['drone_secret'] = "ATTRagentTOKEN"
      end
      runner.converge(described_recipe)
    end

    before do
      stub_command("docker info | grep 'Storage Driver: aufs'").and_return false
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'creates agent container' do
      expect(chef_run).to run_docker_container('agent').with(repo: 'drone/agent', tag: '0.8')
    end

    it 'mounts docker socket' do
      expect(chef_run).to run_docker_container('agent')
        .with(volumes_binds: ['/var/run/docker.sock:/var/run/docker.sock'])
    end

    describe 'agent container environment' do
      let(:agent_env) do
        chef_run.docker_container('agent').env
      end

      it 'sets DRONE_SERVER from attribute' do
        expect(agent_env).to include('DRONE_SERVER=localhost:9000')
      end

      it 'sets DRONE_TOKEN from attribute' do
        expect(agent_env).to include('DRONE_SECRET=ATTRagentTOKEN')
      end

      it 'is sensitive' do
        expect(chef_run).to run_docker_container('agent').with(sensitive: true)
      end
    end
  end

  context 'When all attributes are default, on ubuntu, getting secrets from vault' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node, server|
        server.create_data_bag('vault_drone', 'drone_secret' => { 'drone_secret' => 'RANDOMagentTOKEN' })
        node.default['drone']['agent']['config']['drone_secret'] = "ATTRagentTOKEN"
      end
      runner.converge(described_recipe)
    end

    before do
      stub_command("docker info | grep 'Storage Driver: aufs'").and_return false
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    describe 'agent container environment' do
      let(:agent_env) do
        chef_run.docker_container('agent').env
      end

      it 'sets secret for DRONE_TOKEN from vault' do
        expect(agent_env).not_to include('DRONE_SECRET=ATTRagentTOKEN')
        expect(agent_env).to include('DRONE_SECRET=RANDOMagentTOKEN')
      end
    end
  end

  context 'When attributes are overridden, on ubuntu, getting secrets from vault' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node, _server|
        node.normal['drone']['agent']['repo'] = 'jmccann/agent'
        node.normal['drone']['version'] = '0.6'
        node.normal['drone']['agent']['volumes'] = ['/var/run/docker.sock:/var/run/docker.sock', '/etc/ssl/certs/ca-bundle.pem:/etc/ssl/certs/ca-bundle.pem']
        node.normal['drone']['docker']['log_driver'] = 'syslog'
        node.normal['drone']['docker']['log_opts'] = 'tag=myapp'
      end
      runner.converge(described_recipe)
    end

    before do
      stub_command("docker info | grep 'Storage Driver: aufs'").and_return false
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs drone from a different repo' do
      expect(chef_run).to run_docker_container('agent').with(repo: 'jmccann/agent')
    end

    it 'installs a different version of drone' do
      expect(chef_run).to run_docker_container('agent').with(tag: '0.6')
    end

    it 'mounts specified volumes' do
      expect(chef_run).to run_docker_container('agent')
        .with(volumes_binds: ['/var/run/docker.sock:/var/run/docker.sock', '/etc/ssl/certs/ca-bundle.pem:/etc/ssl/certs/ca-bundle.pem'])
    end

    it 'uses custom logging' do
      expect(chef_run).to run_docker_container('agent')
        .with(log_driver: 'syslog', log_opts: { 'tag' => 'myapp' })
    end
  end
end
