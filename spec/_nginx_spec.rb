require 'spec_helper'

describe 'drone::_nginx' do
  context 'When all attributes are default, on ubuntu' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |_node, server|
        inject_databags server
      end
      runner.converge(described_recipe)
    end

    it 'installs SSL cert' do
      expect(chef_run).to create_ssl_certificate('drone')
        .with(source: 'chef-vault', bag: 'vault_drone', key_item: 'certs',
              key_item_key: 'key', cert_item: 'certs', cert_item_key: 'cert')
    end

    it 'enables nginx site' do
      expect(chef_run).to enable_nginx_site('default')
        .with(template: 'drone.erb')
    end
  end
end
