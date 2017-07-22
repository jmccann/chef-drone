#
# Cookbook Name:: drone
# Spec:: server
#

require 'spec_helper'

describe 'drone::server' do
  context 'When all attributes are default, on ubuntu, getting secrets from attribtues' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node, _server|
        node.default['drone']['server']['config']['drone_secret'] = "ATTRagentSECRET"
      end
      runner.converge(described_recipe)
    end

    before do
      stub_command("docker info | grep 'Storage Driver: aufs'").and_return false
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'creates drone container' do
      expect(chef_run).to run_docker_container('drone')
        .with(repo: 'drone/drone', tag: '0.8', port: ['80:8000', '9000:9000'],
              volumes_binds: ['/var/lib/drone:/var/lib/drone',
                              '/var/run/docker.sock:/var/run/docker.sock'])
    end

    describe 'drone container environment' do
      let(:drone_env) do
        chef_run.docker_container('drone').env
      end

      it 'does not set database driver' do
        expect(drone_env).to include('DRONE_DATABASE_DRIVER=sqlite3')
      end

      it 'does not set database config' do
        expect(drone_env).to include('DRONE_DATABASE_CONFIG=/var/lib/drone/drone.sqlite')
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
        node.default['drone']['server']['config']['drone_secret'] = "ATTRagentSECRET"
      end
      runner.converge(described_recipe)
    end

    before do
      stub_command("docker info | grep 'Storage Driver: aufs'").and_return false
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
        node.normal['drone']['server']['repo'] = 'jmccann/drone'
        node.normal['drone']['version'] = '0.6'
        node.normal['drone']['server']['port'] = ['443:8000', '9001:9000']
        node.normal['drone']['server']['volumes'] = ['/var/lib/drone:/var/lib/drone', '/var/run/docker.sock:/var/run/docker.sock', '/etc/ssl/certs/drone.pem:/etc/ssl/certs/drone.pem', '/etc/ssl/private/drone.key:/etc/ssl/private/drone.key']
        node.normal['drone']['docker']['log_driver'] = 'syslog'
        node.normal['drone']['docker']['log_opts'] = 'tag=myapp'
      end
      runner.converge(described_recipe)
    end

    before do
      stub_command("docker info | grep 'Storage Driver: aufs'").and_return false
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs drone from a different repo' do
      expect(chef_run).to run_docker_container('drone').with(repo: 'jmccann/drone')
    end

    it 'installs a different version of drone' do
      expect(chef_run).to run_docker_container('drone').with(tag: '0.6')
    end

    it 'runs drone on a different port' do
      expect(chef_run).to run_docker_container('drone').with(port: ['443:8000', '9001:9000'])
    end

    it 'runs drone with different volumes' do
      expect(chef_run).to run_docker_container('drone')
        .with(volumes_binds: ['/var/lib/drone:/var/lib/drone', '/var/run/docker.sock:/var/run/docker.sock',
                              '/etc/ssl/certs/drone.pem:/etc/ssl/certs/drone.pem',
                              '/etc/ssl/private/drone.key:/etc/ssl/private/drone.key'])
    end

    it 'uses custom logging' do
      expect(chef_run).to run_docker_container('drone')
        .with(log_driver: 'syslog', log_opts: { 'tag' => 'myapp' })
    end
  end
end
