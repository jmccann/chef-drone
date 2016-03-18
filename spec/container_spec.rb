#
# Cookbook Name:: drone
# Spec:: container
#

require 'spec_helper'

describe 'drone::container' do
  context 'When all attributes are default, on an unspecified platform' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'creates drone container' do
      expect(chef_run).to run_docker_container('drone')
    end

    it 'sets drone container hosts' do
      drone_container_resource = chef_run.docker_container 'drone'
      expect(drone_container_resource.env).to include('DOCKER_HOST_1=unix:///var/run/docker.sock')
      expect(drone_container_resource.env).to include('DOCKER_HOST_2=unix:///var/run/docker.sock')
    end
  end
end
