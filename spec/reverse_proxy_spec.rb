#
# Cookbook Name:: drone
# Spec:: reverse_proxy
#

require 'spec_helper'

describe 'drone::reverse_proxy' do
  context 'When all attributes are default, on ubuntu' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |_node, server|
        inject_databags server
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs webserver' do
      expect(chef_run).to include_recipe 'drone::_nginx'
    end

    it 'binds drone port to 8000 instead of 80, freeing for webserver' do
      expect(chef_run).to run_docker_container('drone').with(port: '8000:8000')
    end
  end
end
