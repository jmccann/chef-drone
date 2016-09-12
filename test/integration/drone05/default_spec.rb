describe file('/var/lib/drone/drone.sqlite') do
  it { should be_file }
end

# nginx
describe port(80) do
  it { should be_listening }
end
describe port(443) do
  it { should be_listening }
end
describe file('/etc/nginx/sites-available/default') do
  its(:content) { should match(/proxy_set_header Upgrade \$http_upgrade;/) }
  its(:content) { should match(/proxy_set_header Connection \$connection_upgrade;/) }

  its(:content) { should_not include('proxy_buffering off;') }
  its(:content) { should_not include('chunked_transfer_encoding off;') }
end

# drone
describe port(8000) do
  it { should be_listening }
end

# Ubuntu image doesn't doesn't have cURL by default but wget can be used.
describe command("wget -q --no-check-certificate https://localhost") do
  its(:exit_status) { should eq 0 }
end

# No logs from agent (meaning no errors)
describe command("docker logs agent") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should eq '' }
  its(:stderr) { should eq '' }
end
