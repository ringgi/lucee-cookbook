#
# Cookbook Name:: lucee
# Attribute File:: default
#
# Author:: Roland Ringgenberg <roland.ringgenberg@ringgi.net>
#
# Copyright 2015 RR Technologies
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['lucee']['app_server'] = 'tomcat'
default['lucee']['app_server']['user'] = 'tomcat'
default['lucee']['major_version'] = '4'
default['lucee']['minor_version'] = '5'

case default['lucee']['app_server']
  when 'tomcat'
    include_attribute 'tomcat'
    default['lucee']['app_server']['user'] = "tomcat#{node['tomcat']['base_version']}"
    default['lucee']['port'] = node['tomcat']['port']
  else
    default['lucee']['port'] = '8888'
end

case node['platform']
  when 'debian', 'ubuntu'
    default['lucee']['base_installation_directory'] = '/opt'
    default['lucee']['config_dir'] = '/var/Lucee/config'
  else
    default['lucee']['base_installation_directory'] = '/opt'
    default['lucee']['config_dir'] = '/var/Lucee/config'
end



