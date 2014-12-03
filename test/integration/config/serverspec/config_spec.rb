require_relative 'spec_helper'

describe 'Drone with custom configuration' do

  describe file('/etc/drone/drone.toml') do
    its(:content) { should match(/port = ":443"/) }
  end

  describe port(443) do
    it { should be_listening }
  end

  # Ubuntu image doesn't doesn't have cURL by default but wget can be used.
  describe command('wget -q --spider localhost:443/install') do
    its(:exit_status) { should eq 0 }
  end
end
