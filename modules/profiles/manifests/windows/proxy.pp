class profiles::windows::proxy (
  $ensure = 'unmanaged',
  $proxyserver   = hiera('profiles::windows::proxy::proxyserver',   undef ),
  $proxyoverride = hiera('profiles::windows::proxy::proxyoverride', undef ),
  $proxysettingsperuser = 1,
){

  validate_re($ensure, '^(enabled|disabled|unmanaged)$', 'valid values for ensure are \'enabled\', \'disabled\', \'unmanaged\'')
    
  case $ensure {
    'enabled': 
    {
      $proxy_enable = 1
      $proxy_override = join($proxyoverride,";")
      $winhttp_ensure = 'present'
    }

    'disabled': 
    {
      $proxy_enable = 0 
      $winhttp_ensure = 'absent'
      #winhttp_proxy { 'proxy': ensure => absent}
    }
  }


  case $ensure {'enabled','diasbled':
    {
      $regbase   = 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings'

      registry_value {   "$regbase\\ProxyEnable": type => dword, data => "$proxy_enable"}
      registry_value {"32:$regbase\\ProxyEnable": type => dword, data => "$proxy_enable"}
         
      registry_value { "$regbase\\ProxyServer":   data => "$proxyserver"}
      registry_value { "$regbase\\ProxyOverride": data => "$proxy_override"}

      registry_value { "32:$regbase\\ProxyServer":   data => "$proxyserver"}
      registry_value { "32:$regbase\\ProxyOverride": data => "$proxy_override"}

      registry_value {    "$regbase\\AutoConfigURL": ensure => absent }
      registry_value { "32:$regbase\\AutoConfigURL": ensure => absent }

      $reg_policy = "HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\ProxySettingsPerUser"
      registry_value {    "$reg_policy": type => dword, data => "$proxysettingsperuser"}
      registry_value { "32:$reg_policy": type => dword, data => "$proxysettingsperuser"}


      # set the system proxy for applications
      #winhttp_proxy { 'proxy': 
      #  ensure       => $winhttp_ensure, 
      #  proxy_server => $winhttp_ensure ? { "absent" => undef, default => $proxyserver}, 
      #  bypass_list  => $winhttp_ensure ? { "absent" => undef, default => $proxyoverride},
      #}
    }
  }
}
