#
# Cookbook Name:: drone
# Spec:: server_secrets
#

require 'spec_helper'

describe 'drone::server_secrets' do
  context 'When all attributes are default, on an unspecified platform' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node, server|
        inject_databags server
        node.set['drone']['config']['drone_agent_secret'] = "ATTRagentSECRET"
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    describe 'agent container environment' do
      let(:drone_env) do
        chef_run.docker_container('drone').env
      end

      it 'sets secret for DRONE_AGENT_SECRET from vault' do
        expect(drone_env).not_to include('DRONE_AGENT_SECRET=ATTRagentSECRET')
        expect(drone_env).to include('DRONE_AGENT_SECRET=RANDOMagentSECRET')
      end
    end
  end
end
