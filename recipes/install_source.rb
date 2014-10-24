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
include_recipe 'golang::default'

directory File.join(node['go']['gopath'], 'src/github.com/drone') do
  owner 'root'
  group 'root'
  mode '00755'
  recursive true
end

git File.join(node['go']['gopath'], '/src/github.com/drone/drone') do
  repository node['drone']['git_url']
  reference node['drone']['git_ref']
  action :checkout
end

golang_package 'github.com/drone/drone' do
  action :install
end

link File.join(node['drone']['install_dir'], 'drone') do
  to File.join(node['go']['gobin'], 'drone')
end
