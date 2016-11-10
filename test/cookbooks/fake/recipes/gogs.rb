# Fix to get supervisord to actually start gogs
r = resources(supervisord_program: 'gogs')
r.directory "#{node['gogs']['install_dir']}/gogs"
r.environment HOME: '/home/git', USER: 'git'
