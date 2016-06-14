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

# drone
describe port(8000) do
  it { should be_listening }
end

# Ubuntu image doesn't doesn't have cURL by default but wget can be used.
describe command("wget -q --no-check-certificate https://localhost") do
  its(:exit_status) { should eq 0 }
end
