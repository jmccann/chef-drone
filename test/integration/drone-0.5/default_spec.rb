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
  its(:stdout) { should include('Version:      17.04.0-ce') }
end

# Make sure running in host network mode
describe command("docker inspect drone") do
  its(:stdout) { should include('"NetworkMode": "bridge"') }
end
describe command("docker inspect agent") do
  its(:stdout) { should include('"NetworkMode": "bridge"') }
end
