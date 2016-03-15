#
# Cookbook Name:: drone
# Spec:: package
#

require 'spec_helper'

describe 'drone::package' do
  context 'When all attributes are default, on an unspecified platform' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    describe '/etc/drone/dronerc' do
      it 'sets SERVER_ADDR' do
        expect(chef_run).to render_file('/etc/drone/dronerc').with_content('SERVER_ADDR=":80"')
      end

      it 'does not set DATABASE_DRIVER' do
        expect(chef_run).to render_file('/etc/drone/dronerc').with_content('DATABASE_DRIVER="sqlite3"')
      end

      it 'does not set DATABASE_CONFIG' do
        expect(chef_run).to render_file('/etc/drone/dronerc').with_content('DATABASE_CONFIG="/var/lib/drone/drone.sqlite"')
      end

      it 'does not set CLIENT' do
        expect(chef_run).not_to render_file('/etc/drone/dronerc').with_content('CLIENT=')
      end

      it 'does not set SECRET' do
        expect(chef_run).not_to render_file('/etc/drone/dronerc').with_content('SECRET=')
      end

      it 'sets REMOTE_DRIVER' do
        expect(chef_run).to render_file('/etc/drone/dronerc').with_content('REMOTE_DRIVER="github"')
      end

      it 'sets REMOTE_CONFIG' do
        expect(chef_run).to render_file('/etc/drone/dronerc')
          .with_content('REMOTE_CONFIG="https://github.com?client_id=${CLIENT}&client_secret=${SECRET}"')
      end

      it 'sets DOCKER_HOST_*' do
        expect(chef_run).to render_file('/etc/drone/dronerc').with_content('DOCKER_HOST_1="unix:///var/run/docker.sock"')
        expect(chef_run).to render_file('/etc/drone/dronerc').with_content('DOCKER_HOST_2="unix:///var/run/docker.sock"')
      end

      it 'sets PLUGIN_FILTER' do
        expect(chef_run).to render_file('/etc/drone/dronerc').with_content('PLUGIN_FILTER="plugins/*"')
      end
    end
  end
end
