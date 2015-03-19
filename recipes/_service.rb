#
# Copyright 2014, Justin Campbell (<justin@justincampbell.me>)
# Copyright 2014 John Bellone <jbellone@bloomberg.net>
# Copyright 2014 Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe 'chef-sugar::default'

template 'drone.conf' do
  source 'drone.conf.erb'
  path node['drone']['config_file']
  mode 0644
  owner 'root'
  group 'root'
  notifies :restart, 'service[drone]', :delayed
end

require_chef_gem 'toml'
file node['drone']['toml_file'] do
  mode 0644
  content ::TOML::Generator.new(node['drone']['config']).body
  notifies :restart, 'service[drone]', :delayed
end

service 'drone' do
  supports status: true, restart: true
  action [:enable, :start]
  subscribes :restart, 'template[drone.conf]', :immediately
  subscribes :restart, "file[#{node['drone']['toml_file']}]", :immediately
end
