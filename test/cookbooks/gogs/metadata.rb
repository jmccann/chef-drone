name             'gogs'
maintainer       'Eddie Hurtig'
maintainer_email 'eddie@hurtigtechnologies.com'
license          'apache2'
description      'Installs and Configures a Go Git Service Server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

supports 'ubuntu', '>= 12.04'

depends 'chef-sugar'
depends 'ark'
depends 'apt'
depends 'supervisord', '~> 1.0.0'
