#
# Cookbook Name:: lucee
# Recipe:: configure_tomcat
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

node.default['tomcat']['catalina_options'] = "-javaagent:#{node['lucee']['base_installation_directory']}/lucee#{node['lucee']['major_version']}/lib/lucee-inst.jar"

execute 'create the lucee config directory' do
  command "mkdir -pv --mode 0775 #{node['lucee']['config_dir']}"
  not_if {::File.exists?("#{node['lucee']['config_dir']}")}
end

execute 'change owner of the lucee directory' do
  command "chown -R #{node['lucee']['user']['id']}:#{node['lucee']['user']['id']} #{node['lucee']['config_dir']}"
end

template "#{node['tomcat']['base']}/conf/catalina.properties" do
  source "catalina.properties.erb"
  mode "0644"
end

template "#{node['tomcat']['base']}/conf/web.xml" do
  source "web.xml.erb"
  mode "0644"
end

execute 'restart tomcat' do
  command "service tomcat#{node['tomcat']['base_version']} restart"
end