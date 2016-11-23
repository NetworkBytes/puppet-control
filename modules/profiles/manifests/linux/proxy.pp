class profiles::linux::proxy {
  include 'profiles::linux::proxy::yum'
  include 'profiles::linux::proxy::profiles' 
}

# YUM
class profiles::linux::proxy::yum (
  Boolean $enabled,
  $proxy_address = 'proxy:3128',
){
  class {'linux_proxy::yum':
    enabled       => $enabled,
    proxy_address => $proxy_address
  }
}

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

