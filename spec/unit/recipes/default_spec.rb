require 'spec_helper'

describe_recipe 'drone::default' do
  it { expect(chef_run).to include_recipe('docker::default') }
  it { expect(chef_run).to include_recipe('drone::_service') }

  describe 'with default attributes' do
    it { expect(chef_run).to include_recipe('drone::install_source')}
  end

  describe %Q(with node['drone']['install_type'] = 'package') do
    let(:chef_run) do
      ChefSpec::Runner.new(node_attributes) do |node|
        node.set['drone']['install_type'] = 'package'
      end.converge(described_recipe)
    end

    it { expect(chef_run).to include_recipe('drone::install_package') }
  end
end
