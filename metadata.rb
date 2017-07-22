name             'drone'
maintainer       'Jacob McCann'
maintainer_email 'jmccann.git@gmail.com'
license          'Apache-2.0'
description      'Installs/Configures Drone'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/jmccann/chef-drone'
issues_url       'https://github.com/jmccann/chef-drone/issues'
chef_version     '>= 12.0.0'
version          '6.0.0'

depends 'chef-vault', '~> 2.1'
depends 'docker', '~> 2.15'
depends 'jmccann-docker-host', '3.0'

supports 'ubuntu', '>= 16.04'
supports 'centos', '>= 7.1'
