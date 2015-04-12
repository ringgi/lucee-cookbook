#
# Cookbook Name:: lucee
# Recipe:: download_jars
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

# Find out the requested Lucee version
case node['lucee']['major_version']
  when '4'
    lucee_version = '4.5.1.000'
  when '5'
    case node['lucee']['minor_version']
      when '0'
        lucee_version = '5.0.0.43'
      else
        lucee_version = '5.0.0.43'
    end
  else
    lucee_version = '4.5.1.000'
end

# Set the download urls and filename
jars_url = "https://bitbucket.org/lucee/lucee/downloads/lucee-#{lucee_version}-jars.zip"
filename = "lucee-#{lucee_version}-jars"

# Directories
lucee_dir = "#{node['lucee']['base_installation_directory']}/lucee#{node['lucee']['major_version']}"


execute 'create the lucee main directory' do
  command "mkdir -pv --mode 0775 #{lucee_dir}"
  not_if {::File.exists?("#{lucee_dir}")}
end

execute 'download lucee jars' do
  command "wget --output-document '#{filename}.zip' #{jars_url}"
  cwd lucee_dir
end

#execute 'untar the tarball' do
#  command "tar -xzvf '#{filename}.tar.gz'"
#  cwd lucee_dir
#end

execute 'unzip' do
  command "unzip '#{filename}.zip'"
  cwd lucee_dir
end

execute 'remove pre-existing lib' do
  command 'rm -rf lib'
  cwd lucee_dir
end

execute 'rename the folder extracted folder' do
  command "mv #{filename} lib"
  cwd lucee_dir
end

execute 'delete existing symlink' do
  command 'rm -f lucee'
  cwd node['lucee']['base_installation_directory']
end

execute 'symlink lucee to current version' do
  command "ln -s lucee#{node['lucee']['major_version']} lucee"
  cwd node['lucee']['base_installation_directory']
end

# Clean up
file_path = "#{lucee_dir}/#{filename}.zip"
file file_path do
  action :delete
end
