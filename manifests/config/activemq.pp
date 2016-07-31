class activemq::config::activemq (
  $ensure           = $activemq::params::ensure,
  $config           = $activemq::params::config,
  $owner            = $activemq::params::owner,
  $group            = $activemq::params::group,
  $mode             = $activemq::params::mode,
  $ensure_file      = $activemq::params::ensure_file,
  $application_path = $activemq::params::application_path,
) {
  # The configuration file itself.
  Concat::Fragment {
    target => 'activemq.xml'
  }
  concat { 'activemq.xml':
    ensure => $ensure,
    path   => "${application_path}/conf/activemq.xml",
    owner  => $owner,
    group  => $group,
  }
  concat::fragment { 'activemq.xml header':
    content => template('activemq/activemq_header.erb'),
    order   => '01',
  }
  if $config['webconsole']['ssl'] {
    concat::fragment { 'activemq.xml webconsole':
      content => "    <import resource=\"jetty.xml\"/> \n",
      order   => '02',
    }
  }
  concat::fragment { 'activemq.xml broker':
    content => template('activemq/activemq_broker.erb'),
    order   => '03',
  }
  if $config['persistence_adapter'] {
    concat::fragment { 'activemq.xml persistence':
      content => template('activemq/activemq_persistence.erb'),
      order   => '04',
    }
  }
  if $config['networkConnectors'] {
    concat::fragment { 'activemq.xml networkconnector':
      content => template('activemq/activemq_connector.erb'),
      order   => '05',
    }
  }
  concat::fragment { 'activemq.xml system':
    content => template('activemq/activemq_system.erb'),
    order   => '06',
  }
  concat::fragment { 'activemq.xml transport':
    content => template('activemq/activemq_transport.erb'),
    order   => '07',
  }
  if $config['plugins'] {
    concat::fragment { 'activemq.xml plugins':
      content => template('activemq/activemq_plugins.erb'),
      order   => '08',
    }
  }
  if $config['policy'] {
    concat::fragment { 'activemq.xml policy':
      content => template('activemq/activemq_policy.erb'),
      order   => '09',
    }
  }
  concat::fragment { 'activemq.xml footer':
    content => '</beans>',
    order   => '10',
  }
}
