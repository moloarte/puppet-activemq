#under construction
class activemq::config::jetty (
  $ensure,
  $application_path,
  $owner,
  $group,
) {
  Concat::Fragment {
    target => 'jetty.xml'
  }
  concat { 'jetty.xml':
    ensure => $ensure,
    path   => "${application_path}/conf/jetty.xml",
    owner  => $owner,
    group  => $group,
  }
  concat::fragment { 'jetty.xml header':
    target => 'jetty.xml',
    source => 'puppet:///modules/activemq/jetty_header',
    order  => '01',
  }
  concat::fragment { 'jetty.xml body':
    target  => 'jetty.xml',
    content => template('activemq/jetty_body.erb'),
    order   => '02',
  }
  concat::fragment {  'jetty.xml webconsole':
    target  => 'activemq.xml',
    content => template('activemq/jetty_webconsole.erb'),
    order   => '03',
  }
  concat::fragment { 'jetty.xml footer':
    content => '</beans>',
    order   => '10',
  }
}

