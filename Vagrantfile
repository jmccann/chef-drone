Vagrant.configure("2") do |config|
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.hostname = "drone"
  config.vm.box = "opscode-ubuntu-13.04"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-13.04_chef-provisionerless.box"

  config.vm.network :forwarded_port, guest: 80, host: (1024..65535).to_a.sample

  config.vm.provision :chef_solo do |chef|
    chef.run_list = %w[
      recipe[drone]
    ]
  end
end
