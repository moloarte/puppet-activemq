## Class: activemq
##
## This module manages the ActiveMQ messaging middleware.
##
## Parameters:
##
## Actions:
##
# Requires:
#
#   Class['java']
#
# Sample Usage:
#
# node default {
#   class { 'activemq': }
# }
#
# To supply your own configuration file:
#
# node default {
#   class { 'activemq':
#     server_config => template('site/activemq.xml.erb'),
#   }
# }
#
class activemq (
  $ensure           = $activemq::params::ensure,
  $ensure_file      = $activemq::params::ensure_file,
  $config           = $activemq::params::config,
  $application_path = $activemq::params::application_path,
  $owner            = $activemq::params::owner,
  $group            = $activemq::params::group,
  $mode             = $activemq::params::mode,
  $version          = $activemq::params::version,
  $package          = $activemq::params::package,
  $credentials      = $activemq::params::credential
) inherits activemq::params {
  include activemq::package
  File {
    owner => $owner,
    group => $group,
  }

  class { 'activemq::config::activemq':
    ensure           => $ensure,
    config           => $config,
    owner            => $owner,
    group            => $group,
    mode             => $mode,
    ensure_file      => $ensure_file,
    application_path => $application_path,
  }
  class { 'activemq::config::credential':
    credentials => $credentials,
    path        => $application_path
  }
}
