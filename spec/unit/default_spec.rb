require 'spec_helper'

describe 'drone::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge('drone::default') }
  let(:drone_dot_conf_template) { chef_run.template('/etc/init/drone.conf') }

  it 'downloads /tmp/drone.deb' do
    expect(chef_run).to create_remote_file_if_missing('/tmp/drone.deb').with(
      source: 'http://downloads.drone.io/latest/drone.deb'
      )
  end

  it 'installs drone' do
    expect(chef_run).to install_dpkg_package('drone').with(
      source: '/tmp/drone.deb'
      )
  end

  it 'installs drone' do
    expect(chef_run).to install_dpkg_package('drone').with(
      source: '/tmp/drone.deb'
      )
  end

  it 'creates /etc/init/drone.conf' do
    expect(chef_run).to create_template('/etc/init/drone.conf').with(
      source: 'drone.conf.erb',
      mode: '0644',
      owner: 'root',
      group: 'root',
      variables: { droned_opts: '--port=:80', drone_tmp: '/tmp/drone' }
      )
  end

  it 'manages the dron service' do
    expect(chef_run).to enable_service('drone')
    expect(chef_run).to start_service('drone')
  end

  it 'sends a notification to the service' do
    expect(drone_dot_conf_template).to notify('service[drone]').delayed
  end
end
