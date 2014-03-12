name             'drone'
maintainer       'Justin Campbell'
maintainer_email 'justin@justincampbell.me'
license          'Apache 2.0'
description      'Installs/Configures Drone'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

%w{ docker mysql database }.each do |dep|
  depends dep
end

supports 'ubuntu', '>= 12.04'
