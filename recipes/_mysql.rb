include_recipe "mysql::client"

if node['drone']['mysql']['install']
  include_recipe "mysql::server"
  include_recipe "database::mysql"

  mysql_connection_info = {
    host:     'localhost',
    username: 'root',
    password: node['mysql']['server_root_password']
  }

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
    privileges    [:select, :update, :insert]
    action        [:grant]
  end

  database_user 'grant privs to drone user@localhost' do
    connection    mysql_connection_info
    provider      Chef::Provider::Database::MysqlUser
    username      node['drone']['mysql']['username']
    password      node['drone']['mysql']['password']
    database_name node['drone']['mysql']['database']
    host          'localhost'
    privileges    [:select, :update, :insert]
    action        [:grant]
  end

end
