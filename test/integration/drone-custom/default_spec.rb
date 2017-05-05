puts 'Waiting for gogs to start'
sleep 5

describe file('/var/lib/drone/drone.sqlite') do
  it { should be_file }
end

# Gogs
describe port(8080) do
  it { should be_listening }
end

# Drone
describe port(9080) do
  it { should be_listening }
end

# Ubuntu image doesn't doesn't have cURL by default but wget can be used.
describe command("wget -q --no-check-certificate http://localhost:9080") do
  its(:exit_status) { should eq 0 }
end

# Agent connects
describe command("docker logs agent") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should eq '' }
  its(:stderr) { should include('pipeline: request next execution') }
end
describe command("docker logs drone") do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should include('agent connected: ip address 172.17.0.1') }
end
