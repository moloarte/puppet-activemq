class activemq::config::credential (
  $credentials,
  $path,
) {
  file { "${path}/conf/credentials.properties":
    content => template('activemq/credentials_config.erb'),
  }
}

