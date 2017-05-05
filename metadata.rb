name             'drone'
maintainer       'Jacob McCann'
maintainer_email 'jmccann.git@gmail.com'
license          'Apache-2.0'
description      'Installs/Configures Drone'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/jmccann/chef-drone'
issues_url       'https://github.com/jmccann/chef-drone/issues'
chef_version     '>= 12.0.0'
version          '4.0.0'

depends 'chef-vault', '~> 1.3'
depends 'docker', '~> 2.9'
depends 'chef_nginx', '~> 6.0'
depends 'ssl_certificate', '~> 1.12'

supports 'ubuntu', '>= 16.04'
supports 'centos', '>= 7.1'
