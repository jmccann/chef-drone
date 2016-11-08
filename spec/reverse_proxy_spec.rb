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

    before do
      # nginx cookbook stubbing
      stub_command('which nginx').and_return(false)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs webserver' do
      expect(chef_run).to include_recipe 'drone::_nginx'
    end

    it 'installs SSL cert' do
      expect(chef_run).to create_ssl_certificate('drone')
        .with(source: 'chef-vault', bag: 'vault_drone', key_item: 'certs',
              key_item_key: 'key', cert_item: 'certs', cert_item_key: 'cert')
    end

    it 'binds drone port to 8000 instead of 80, freeing for webserver' do
      expect(chef_run).to run_docker_container('drone').with(port: '8000:8000')
    end

    it 'does not disable repo activation' do
      expect(chef_run).not_to render_file('/etc/nginx/sites-available/default').with_content '# Deny activation of new repos'
    end

    it 'does not enable repo activation for whitelisted orgs' do
      expect(chef_run).not_to render_file('/etc/nginx/sites-available/default').with_content '# Allow activatation of new repos for whitelisted org'
    end
  end

  context 'When some attributes are overriden, on ubuntu' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node, server|
        node.set['drone']['disable_repo_activation'] = true
        node.set['drone']['repo_activation_org_whitelist'] = ['test_org']

        inject_databags server
      end
      runner.converge(described_recipe)
    end

    before do
      # nginx cookbook stubbing
      stub_command('which nginx').and_return(false)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'disables repo activation' do
      expect(chef_run).to render_file('/etc/nginx/sites-available/default').with_content '# Deny activation of new repos'
    end

    it 'allows repo activation for specified org' do
      expect(chef_run).to render_file('/etc/nginx/sites-available/default').with_content '# Allow activatation of new repos for whitelisted org test_org'
    end
  end
end
