name              'lucee'
maintainer        'Roland Ringgenberg'
maintainer_email  'roland.ringgenberg@ringgi.net'
license           'Apache 2.0'
description       'Install and setup Lucee'
long_description  'The cookbook installs Lucee on an existing Java Application Server'
version           '0.1.0'

depends   'tomcat'

supports  'ubuntu'

recipe 'lucee::default', 'Runs the lucee::tomcat_server recipe'
recipe 'lucee::tomcat_server', 'Installs Lucee on Tomcat'
