require_relative 'spec_helper'

describe 'Drone with custom configuration' do
  describe file('/etc/drone/dronerc') do
    its(:content) { should match(/SERVER_ADDR=":443"/) }
  end

  describe port(443) do
    it { should be_listening }
  end

  # Ubuntu image doesn't doesn't have cURL by default but wget can be used.
  describe command('wget -q --spider ' + `hostname` + ':443/login') do
    its(:exit_status) { should eq 0 }
  end
end

# TODO, add docker running
# TODO, tls certs in place
