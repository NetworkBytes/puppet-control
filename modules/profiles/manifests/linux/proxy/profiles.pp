# BASH PROFILES
class profiles::linux::proxy::profiles (
  Boolean $enabled,
  $proxy_address = 'proxy:3128',
  # hiera array required to do a array merge between hiera hierarchies
  $bypass = hiera_array('profiles::linux::proxy::bypass', [])
){
  class {'linux_proxy::profiles':
    enabled       => $enabled,
    proxy_address => $proxy_address,
    no_proxy      => $bypass
  }
}

