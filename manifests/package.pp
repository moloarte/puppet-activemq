class activemq::package (
  $version = $activemq::params::version,
  $package = $activemq::params::package,
  $service = $activemq::params::service,
) {
  package { $package:
    ensure => $version,
  }

  if $activemq::params::service {
    service { 'activemq':
      ensure  => 'running',
      enable  => true,
      start   => $service['start'],
      stop    => $service['stop'],
      restart => $service['restart'],
      status  => $service['status'],
      require => Package[$package]
    }
  } else {
    service { 'activemq':
      ensure  => 'running',
      enable  => true,
      require => Package[$package]
    }
  }
}
