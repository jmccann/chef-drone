require 'spec_helper'

describe_recipe 'drone::install_package' do
  it do
    expect(chef_run).to install_package('drone')
      .with(source: 'https://downloads.drone.io/latest/drone.deb')
  end
end
