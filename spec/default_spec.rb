#
# Cookbook Name:: drone
# Spec:: default
#

require 'spec_helper'

describe 'drone::default' do
  context 'When all attributes are default, on ubuntu, getting secrets from attribtues' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node, _server|
        node.default['drone']['config']['drone_secret'] = "ATTRagentSECRET"
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'creates drone container' do
      expect(chef_run).to run_docker_container('drone').with(repo: 'drone/drone', tag: '0.4', port: '80:8000')
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

      it 'sets DRONE_AGENT_SECRET from attr' do
        expect(drone_env).to include('DRONE_SECRET=ATTRagentSECRET')
      end

      it 'is sensitive' do
        expect(chef_run).to run_docker_container('drone').with(sensitive: true)
      end
    end
  end

  context 'When all attributes are default, on ubuntu, getting secrets from vault' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node, server|
        inject_databags server
        node.default['drone']['config']['drone_secret'] = "ATTRagentSECRET"
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
        expect(drone_env).not_to include('DRONE_SECRET=ATTRagentSECRET')
        expect(drone_env).to include('DRONE_SECRET=RANDOMagentSECRET')
      end
    end
  end

  context 'When attributes are set, on ubuntu' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node, _server|
        node.normal['drone']['port'] = '443'
        node.normal['drone']['repo'] = 'jmccann/drone'
        node.normal['drone']['version'] = '0.5'
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs drone from a different repo' do
      expect(chef_run).to run_docker_container('drone').with(repo: 'jmccann/drone')
    end

    it 'installs a different version of drone' do
      expect(chef_run).to run_docker_container('drone').with(tag: '0.5')
    end

    it 'runs drone on a different port' do
      expect(chef_run).to run_docker_container('drone').with(port: '443:8000')
    end
  end
end
