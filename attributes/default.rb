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
default['drone']['install_type'] = 'source'
default['drone']['install_dir'] = '/usr/local/bin'

default['drone']['git_url'] = 'https://github.com/drone/drone.git'
default['drone']['git_ref'] = 'v0.2.0'

default['drone']['package_url'] = 'https://downloads.drone.io/latest/drone.deb'

default['drone']['config_file'] = '/etc/init/drone.conf'
default['drone']['drone_tmp'] = '/tmp/drone'
default['drone']['toml_file'] = '/etc/drone/drone.toml'
default['drone']['config'] = {
  'server' => {
    'port' => ':80'
  },
  'database' => {
    'driver' => 'sqlite3',
    'datasource' => '/var/lib/drone/drone.sqlite'
  },
  'registration' => {
    'open' => true
  }
}
