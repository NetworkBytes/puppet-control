class profiles::apache::vhosts {

  $apache_vhosts = hiera_hash('profiles::apache::vhosts', false)
  $apache_vhosts_defaults = {
    ensure          => present,
  }

  if $apache_vhosts {
    create_resources ( '::apache::vhost', $apache_vhosts, $apache_vhosts_defaults )
  } else {
    notify {"Info: no profiles::apache::vhosts hash found in hiera for this node, not managing apache vhosts":}
  }
}
