name             'drone'
maintainer       'Justin Campbell'
maintainer_email 'justin@justincampbell.me'
license          'Apache 2.0'
description      'Installs/Configures Drone'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/justincampbell/chef-drone'
issues_url       'https://github.com/justincampbell/chef-drone/issues'
version          '1.0.0'

depends 'chef-vault', '~> 1.3'
depends 'docker', '~> 2.5.3'
depends 'nginx', '~> 2.7'
depends 'ssl_certificate', '~> 1.12'

supports 'ubuntu', '>= 14.04'
