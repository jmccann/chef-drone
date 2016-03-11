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

    it 'properly renders dronerc file' do
      expect(chef_run).to render_file('/etc/drone/dronerc').with_content('SERVER_ADDR=":80"')
      expect(chef_run).to render_file('/etc/drone/dronerc').with_content('DOCKER_HOST_1="unix:///var/run/docker.sock"')
      expect(chef_run).to render_file('/etc/drone/dronerc').with_content('DOCKER_HOST_2="unix:///var/run/docker.sock"')
    end
  end
end
