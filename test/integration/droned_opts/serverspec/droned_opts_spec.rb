require_relative 'spec_helper'

describe 'Drone with custom runtime flags/options' do

  it 'should have correct --port flag' do
    expect(process('droned').args).to match /--port=:443\b/
  end

  it 'should have correct --workers flag' do
    expect(process('droned').args).to match /--workers=2\b/
  end

  it 'should be listening on port 443' do
    expect(port 443).to be_listening
  end

  # Ubuntu image doesn't doesn't have cURL by default but wget can be used.
  it 'should respond to HTTP request' do
    expect(command 'wget -q --spider localhost:443/install' ).to return_exit_status 0
  end
end

