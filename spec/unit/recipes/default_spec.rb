require 'spec_helper'

describe_recipe 'drone::default' do
  before do
    stub_command("/usr/local/go/bin/go version | grep \"go1.3 \"").and_return(false)
  end
end
