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

# Should be logging to syslog
describe command("docker logs agent") do
  its(:exit_status) { should eq 1 }
end

# No logs from agent (meaning no errors)
log_file = "/var/log/syslog"
log_file = "/var/log/messages" if os[:family] == "redhat"

describe file(log_file) do
  its(:content) { should include('pipeline: request next execution') }
end

# Make sure running in host network mode
describe command("docker inspect drone") do
  its(:stdout) { should include('"NetworkMode": "host"') }
end
describe command("docker inspect agent") do
  its(:stdout) { should include('"NetworkMode": "host"') }
end
