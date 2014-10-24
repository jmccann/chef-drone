require 'spec_helper'

describe_recipe 'drone::install_package' do
  it do
    expect(chef_spec).to install_package('drone')
      .with(source: 'http://downloads.drone.io/latest/drone.deb')
  end
end
