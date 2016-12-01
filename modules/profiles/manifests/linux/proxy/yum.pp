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
