#
# Cookbook Name:: drone
# Spec:: _docker
#

require 'spec_helper'

describe 'drone::_docker' do
  context 'When all attributes are default, on ubuntu' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    before do
      stub_command("docker info | grep 'Storage Driver: aufs'").and_return false
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs docker' do
      expect(chef_run).to create_docker_installation_package('default')
    end

    it 'sets docker logging to info' do
      expect(chef_run).to start_docker_service_manager('default').with(log_level: :info)
    end

    it 'sets docker storage driver to aufs' do
      expect(chef_run).to start_docker_service_manager('default').with(storage_driver: ['aufs'])
    end
  end

  context 'When all attributes are default, on ubuntu' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node, _server|
        node.override['drone']['docker']['version'] = '17.04.0'
        node.override['drone']['docker']['daemon']['log_level'] = 'debug'
        node.override['drone']['docker']['cidr_v4'] = '192.168.0.0/16'
      end
      runner.converge(described_recipe)
    end

    before do
      stub_command("docker info | grep 'Storage Driver: aufs'").and_return false
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs docker at pinned version' do
      expect(chef_run).to create_docker_installation_package('default').with(version: '17.04.0')
    end

    it 'sets docker logging to debug' do
      expect(chef_run).to start_docker_service_manager('default').with(log_level: :debug)
    end

    it 'sets docker subnet to 192.168.0.0/16' do
      expect(chef_run).to start_docker_service_manager('default').with(fixed_cidr: '192.168.0.0/16')
    end
  end

  context 'When all attributes are default, on an centos' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'redhat', version: '7.2')
      runner.converge(described_recipe)
    end

    before do
      stub_command("docker info | grep 'Storage Driver: devicemapper'").and_return false
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs docker' do
      expect(chef_run).to create_docker_installation_package('default')
    end

    it 'sets docker logging to info' do
      expect(chef_run).to start_docker_service_manager('default').with(log_level: :info)
    end

    it 'sets docker storage driver to aufs' do
      expect(chef_run).to start_docker_service_manager('default').with(storage_driver: ['devicemapper'])
    end
  end

  context 'When all attributes are default, on centos' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'redhat', version: '7.2') do |node, _server|
        node.override['drone']['docker']['version'] = '17.04.0'
        node.override['drone']['docker']['daemon']['log_level'] = 'debug'
        node.override['drone']['docker']['cidr_v4'] = '192.168.0.0/16'
      end
      runner.converge(described_recipe)
    end

    before do
      stub_command("docker info | grep 'Storage Driver: devicemapper'").and_return false
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs docker at pinned version' do
      expect(chef_run).to create_docker_installation_package('default').with(version: '17.04.0')
    end

    it 'sets docker logging to debug' do
      expect(chef_run).to start_docker_service_manager('default').with(log_level: :debug)
    end

    it 'sets docker subnet to 192.168.0.0/16' do
      expect(chef_run).to start_docker_service_manager('default').with(fixed_cidr: '192.168.0.0/16')
    end
  end
end
