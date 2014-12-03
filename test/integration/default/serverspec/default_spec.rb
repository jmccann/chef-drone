require_relative 'spec_helper'

describe 'Drone CI server' do
  describe file('/usr/local/bin/drone') do
    it { should be_executable }
  end

  describe file('/usr/local/bin/droned') do
    it { should be_executable }
  end

  describe service('drone') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/var/lib/drone/drone.sqlite') do
    it { should be_file }
  end

  describe port(80) do
    it { should be_listening }
  end

  # Ubuntu image doesn't doesn't have cURL by default but wget can be used.
  describe command('wget -q --spider localhost/install') do
    its(:exit_status) { should eq 0 }
  end
end
