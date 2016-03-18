#
# Cookbook Name:: drone
# Spec:: default
#

require 'spec_helper'

describe 'drone::default' do
  context 'When all attributes are default, on an unspecified platform' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs drone via container method' do
      expect(chef_run).to include_recipe 'drone::container'
    end
  end
end
