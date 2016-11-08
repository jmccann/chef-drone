#
# Cookbook Name:: drone
# Spec:: agent
#

require 'spec_helper'

describe 'drone::agent' do
  context 'When all attributes are default, on an unspecified platform, getting secrets from attribtues' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node, _server|
        node.default['drone']['agent']['config']['drone_secret'] = "ATTRagentTOKEN"
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'creates agent container' do
      expect(chef_run).to run_docker_container('agent').with(tag: '0.4')
    end

    describe 'agent container environment' do
      let(:agent_env) do
        chef_run.docker_container('agent').env
      end

      it 'sets DRONE_SERVER from attribute' do
        expect(agent_env).to include('DRONE_SERVER=ws://localhost/ws/broker')
      end

      it 'sets DRONE_TOKEN from attribute' do
        expect(agent_env).to include('DRONE_SECRET=ATTRagentTOKEN')
      end

      it 'is sensitive' do
        expect(chef_run).to run_docker_container('agent').with(sensitive: true)
      end
    end
  end

  context 'When all attributes are default, on an unspecified platform, getting secrets from vault' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node, server|
        server.create_data_bag('vault_drone', 'drone_secret' => { 'drone_secret' => 'RANDOMagentTOKEN' })
        node.default['drone']['agent']['config']['drone_secret'] = "ATTRagentTOKEN"
      end
      runner.converge(described_recipe)
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
end
