#
# Cookbook Name:: drone
# Spec:: agent_secrets
#

require 'spec_helper'

describe 'drone::agent_secrets' do
  context 'When all attributes are default, on an unspecified platform' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node, server|
        server.create_data_bag('vault_drone', 'drone_token' => { 'drone_token' => 'RANDOMagentTOKEN' })
        node.set['drone']['agent']['config']['drone_token'] = "ATTRagentTOKEN"
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
        expect(agent_env).not_to include('DRONE_TOKEN=ATTRagentTOKEN')
        expect(agent_env).to include('DRONE_TOKEN=RANDOMagentTOKEN')
      end
    end
  end
end
