
# BASE APACHE CONFIG
class profiles::apache::base (
  Boolean $default_vhost = false,
  Boolean $default_ssl_vhost = false,
  Boolean $default_mods = true
){

  class {'::apache':
    default_vhost     => $default_vhost,
    default_ssl_vhost => $default_ssl_vhost,
    default_mods      => $default_mods
  }

}
