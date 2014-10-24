require 'spec_helper'

describe_recipe 'drone::install_source' do
  before do
    stub_command("/usr/local/go/bin/go version | grep \"go1.2 \"").and_return(false)
  end

  it { expect(chef_spec).to include_recipe('golang::default') }
  it { expect(chef_run).to create_directory('/opt/go/src/github.com/drone') }
  it { expect(chef_run).to checkout_git('/opt/go/src/github.com/drone/drone') }
  it { expect(chef_run).to install_golang_package('github.com/drone/drone') }
  it { expect(chef_run.link('/usr/local/bin/drone')).to link_to('/opt/go/bin/drone') }
end
