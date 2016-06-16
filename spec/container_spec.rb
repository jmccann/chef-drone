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
      expect(chef_run).to run_docker_container('drone').with(tag: '0.4')
    end

    describe 'drone container environment' do
      let(:drone_env) do
        chef_run.docker_container('drone').env
      end

      it 'does not set database driver' do
        expect(drone_env).to include('DATABASE_DRIVER=sqlite3')
      end

      it 'does not set database config' do
        expect(drone_env).to include('DATABASE_CONFIG=/var/lib/drone/drone.sqlite')
      end

      it 'sets remote driver' do
        expect(drone_env).to include('REMOTE_DRIVER=github')
      end

      it 'sets remote config' do
        expect(drone_env).to include('REMOTE_CONFIG=https://github.com?client_id=${CLIENT}&client_secret=${SECRET}')
      end

      it 'sets drone docker hosts' do
        expect(drone_env).to include('DOCKER_HOST_1=unix:///var/run/docker.sock')
        expect(drone_env).to include('DOCKER_HOST_2=unix:///var/run/docker.sock')
      end

      it 'sets PLUGIN_FILTER' do
        expect(drone_env).to include('PLUGIN_FILTER=plugins/*')
      end

      it 'is sensitive' do
        expect(chef_run).to run_docker_container('drone').with(sensitive: true)
      end
    end
  end
end
