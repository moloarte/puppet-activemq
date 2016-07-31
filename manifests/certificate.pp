class activemq::certificate  (
  $password = $activemq::params::password,
  $destination = $activemq::params::destination,
) {
  exec { 'genetrate activemq certificate':
    command => "/usr/bin/keytool -alias mq-${::fqdn} -validity 1095 -keystore mq-${::fqdn} \
                -storetype JKS -s storepass ${password}",
    creates => $destination,
  }
}
