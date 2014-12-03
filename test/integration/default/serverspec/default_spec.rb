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
    it { should exist }
  end

  it 'should be listening on port 80' do
    expect(port 80).to be_listening
  end

  # Ubuntu image doesn't doesn't have cURL by default but wget can be used.
  it 'should respond to HTTP request' do
    result = command('wget -q --spider http://localhost/install')
    expect(result.exit_status).to eq(0)
  end
end
