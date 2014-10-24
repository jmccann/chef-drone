require 'spec_helper'

describe_recipe 'drone::_service' do
  it do
    expect(chef_run).to create_template('template[drone.conf]')
      .with(source: 'drone.conf.erb')
      .with(path: '/etc/init/drone.conf')
      .with(mode: 0644)
      .with(owner: 'root')
      .with(group: 'root')
      .with(variables: {
        droned_opts: '--port=:80',
        drone_tmp: '/tmp/drone'
      })
  end

  it { expect(chef_run).to enable_service('drone') }
  it { expect(chef_run).to start_service('drone') }
end
