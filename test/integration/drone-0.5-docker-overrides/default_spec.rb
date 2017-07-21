describe file('/var/lib/drone/drone.sqlite') do
  it { should be_file }
end

describe port(80) do
  it { should be_listening }
end

# Ubuntu image doesn't doesn't have cURL by default but wget can be used.
describe command("wget -q --no-check-certificate http://localhost") do
  its(:exit_status) { should eq 0 }
end

# No logs from agent (meaning no errors)
describe command("docker logs agent") do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should include('connection established, ready to process builds') }
end

# Make sure correct docker version installed
describe command("docker version") do
  its(:stdout) { should include('Version:      17.05.0-ce') }
end

# Make sure running in host network mode
describe command("docker inspect drone") do
  its(:stdout) { should include('"NetworkMode": "host"') }
end
describe command("docker inspect agent") do
  its(:stdout) { should include('"NetworkMode": "host"') }
end

describe command("route -n") do
  its(:stdout) { should include('192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 docker0') }
end

describe command("ip a show dev docker0") do
  its(:stdout) { should include('inet 192.168.1.1/24') }
end
