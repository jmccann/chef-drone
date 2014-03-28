
# if ubuntu need apt-get update run at compiletime for mysql install
case node["platform"] 
when "debian", "ubuntu"
  execute "compile-time-apt-get-update" do 
    command "apt-get update" 
    ignore_failure true 
    action :nothing 
  end.run_action(:run) 
end

include_recipe 'mysql::client'

if node['drone']['mysql']['install']
  include_recipe "mysql::server"
  include_recipe "database::mysql"

  mysql_connection_info = {
    host:     'localhost',
    username: 'root',
    password: node['mysql']['server_root_password']
  }

template '/etc/mysql/conf.d/drone.cnf' do
    source 'drone_mysql.cnf.erb'
    mode 0644
    owner 'root'
    group 'root'
    notifies :restart, 'service[mysql]', :delayed
  end

  database 'create drone database' do
    connection mysql_connection_info
    database_name   node['drone']['mysql']['database']
    provider        Chef::Provider::Database::Mysql
    action          [:create]
  end

  database_user 'grant privs to drone user@%' do
    connection    mysql_connection_info
    provider      Chef::Provider::Database::MysqlUser
    username      node['drone']['mysql']['username']
    password      node['drone']['mysql']['password']
    database_name node['drone']['mysql']['database']
    host          '%'
    privileges    [:select, :update, :insert, :create, :index]
    action        [:grant]
  end

  database_user 'grant privs to drone user@localhost' do
    connection    mysql_connection_info
    provider      Chef::Provider::Database::MysqlUser
    username      node['drone']['mysql']['username']
    password      node['drone']['mysql']['password']
    database_name node['drone']['mysql']['database']
    host          'localhost'
    privileges    [:select, :update, :insert, :create, :index]
    action        [:grant]
  end

end
