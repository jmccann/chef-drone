name             'drone'
maintainer       'Justin Campbell'
maintainer_email 'justin@justincampbell.me'
license          'Apache 2.0'
description      'Installs/Configures Drone'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.7.9'

depends 'docker', '~> 2.5.3'
depends 'ssl_certificate'

supports 'ubuntu', '>= 12.04'
