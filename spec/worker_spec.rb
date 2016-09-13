#
# Cookbook Name:: drone
# Spec:: worker
#

require 'spec_helper'

describe 'drone::worker' do
  context 'When all attributes are default, on an unspecified platform' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs docker' do
      expect(chef_run).to include_recipe 'drone::_docker'
    end

    it 'exposed docker port for drone server' do
      expect(chef_run).to start_docker_service_manager('default').with(host: ['unix:///var/run/docker.sock', 'tcp://10.0.0.2:2376'])
    end
  end
end
