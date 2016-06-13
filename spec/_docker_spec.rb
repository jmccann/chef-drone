#
# Cookbook Name:: drone
# Spec:: _docker
#

require 'spec_helper'

describe 'drone::_docker' do
  context 'When all attributes are default, on an unspecified platform' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs kernel extras for aufs' do
      expect(chef_run).to install_package 'linux-image-extra-4.4.0-21-generic'
    end

    it 'installs docker' do
      expect(chef_run).to create_docker_service('default')
    end
  end
end
