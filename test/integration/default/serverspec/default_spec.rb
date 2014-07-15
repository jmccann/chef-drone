require_relative 'spec_helper'

describe 'Drone CI server' do

  it 'should install drone' do
    expect(file '/usr/local/bin/drone').to be_file
    expect(file '/usr/local/bin/drone').to be_executable
  end

  it 'should install droned' do
    expect(file '/usr/local/bin/droned').to be_file
    expect(file '/usr/local/bin/droned').to be_executable
  end

  it 'service should be running and enabled' do
    expect(service 'drone').to be_running
    expect(service 'drone').to be_enabled
  end

  it 'should be listening on port 80' do
    expect(port 80).to be_listening
  end

  # Ubuntu image doesn't doesn't have cURL by default but wget can be used.
  it 'should respond to HTTP request' do
    expect(command 'wget -q --spider http://localhost/install' ).to return_exit_status 0
  end
end
