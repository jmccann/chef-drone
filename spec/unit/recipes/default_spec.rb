require 'spec_helper'

describe_recipe 'drone::default' do
  before do
    stub_command("/usr/local/go/bin/go version | grep \"go1.3 \"").and_return(false)
  end

  it { expect(chef_run).to include_recipe('docker::default') }
  it { expect(chef_run).to include_recipe('drone::_service') }

  context 'with default attributes' do
    it { expect(chef_run).to include_recipe('drone::install_source') }
  end

  context %Q(with node['drone']['install_type'] = 'package') do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.set['drone']['install_type'] = 'package'
      end.converge(described_recipe)
    end

    it { expect(chef_run).to include_recipe('drone::install_package') }
  end
end
