name             'drone'
maintainer       'Jacob McCann'
maintainer_email 'jmccann.git@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures Drone'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/jmccann/chef-drone'
issues_url       'https://github.com/jmccann/chef-drone/issues'
version          '2.4.0'

depends 'chef-vault', '~> 1.3'
depends 'docker', '~> 2.8.0'
depends 'nginx', '~> 2.7'
depends 'ssl_certificate', '~> 1.12'

supports 'ubuntu', '>= 14.04'
