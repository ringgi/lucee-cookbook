Lucee Cookbook
=================

This cookbook installs Lucee (atm on tomcat only)

Requirements
------------

The cookbook has been tested on Ubuntu 14.04, but should work on most platforms where Java 7 or 8 work.

### Platforms
- Ubuntu

### Cookbooks
- java
- tomcat

And the dependencies of the java and tomcat cookbooks

Attributes
----------
* `node['lucee']['app_server']` Type of web application server (currently only tomcat)
* `node['lucee']['app_server']['user']` The user with execution rights, default `tomcat` 
* `node['lucee']['major_version']` Major version of Railo, default `4`
* `node['lucee']['minor_version']` Minor version of Railo, default `5`
* `node['lucee']['port']` The Lucee/Tomcat port, default `8080`
* `node['lucee']['base_installation_directory']` Root directory where the /railo/lib directories will be installed, default `/opt`
* `node['lucee']['config_dir']` Full path to the railo configuration directory where the /server and /web directories will be created by Railo, default `/var/Lucee/config`

Usage
-----
Just include `recipe[lucee]` in your node's `run_list` and configure the java and tomcat cookbooks:

```json
{
    "name": "lucee-server",
    "description": "A Lucee server based on Tomcat",
    "json_class": "Chef::Role",
    "default_attributes": {
        "java": {
            "jdk_version": "8"
        },
        "tomcat": {
            "base_version": "8",
            "deploy_manager_apps": false
        },
        "railo": {
            "major_version": "5",
            "minor_version": "0"
        }
    },
    "override_attributes": {
    },
    "chef_type": "role",
    "run_list": [
        "recipe[lucee]"
    ]
}
```

Running the tests
-----------------

A ruby environment with Bundler installed is a prerequisite for using
the testing harness shipped with this cookbook. At the time of this
writing, it works with Ruby 2.0 and Bundler 1.5.3. All programs
involved, with the exception of Vagrant, can be installed by cd'ing
into the parent directory of this cookbook and running "bundle install"

The Rakefile currently ships with an integration test task. Integration tests can also be ran with Test Kitchen
cloud drivers.

Integration tests can be performed on a local workstation using
Virtualbox or VMWare. Detailed instructions for setting this up can be
found at the [Bento](https://github.com/opscode/bento) project web site.

Integration tests using Vagrant can be performed with either
```
bundle exec kitchen test
```
or
```
rake integration:vagrant
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Test your change
5. Submit a Pull Request

License & Authors
-----------------
- Author:: Roland Ringgenberg (<roland.ringgenberg@ringgi.net>)

```text
   Copyright 2015 RRTechnologies

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
```
