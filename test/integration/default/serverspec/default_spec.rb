require_relative 'spec_helper'

describe 'Drone CI server' do
  describe file('/var/lib/drone/drone.sqlite') do
    it { should be_file }
  end

  describe port(80) do
    it { should be_listening }
  end

  # Ubuntu image doesn't doesn't have cURL by default but wget can be used.
  describe command("wget -q #{host_inventory['hostname']}/login") do
    its(:exit_status) { should eq 0 }
  end
end
