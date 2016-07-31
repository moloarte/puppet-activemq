class activemq::params {
  $ensure = 'latest'
  
  $ensure_file = $ensure ? {
    absent  => 'absent',
    default => 'present'
  }

  $config = {}
  $application_path = '/usr/local/apache-activemq/'
  $version = 'latest'
  $package = 'java-activemq'
  $owner   = 'activemq'
  $group   = 'activemq'
  $mode    = '0644'
  $service = undef
  $credential = {
    'activemq.username' => 'dr34mscape.admin',
    'activemq.password' => '1qaz2wsx3edc'
  }
}
