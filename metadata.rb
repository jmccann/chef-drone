name             'drone'
maintainer       'Justin Campbell'
maintainer_email 'justin@justincampbell.me'
license          'Apache 2.0'
description      'Installs/Configures Drone'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.5.0'

depends 'chef-sugar'
depends 'docker'
depends 'golang'

supports 'redhat', '>= 6.5'
supports 'centos', '>= 6.5'
supports 'ubuntu', '>= 12.04'
