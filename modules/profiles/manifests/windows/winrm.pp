class profiles::windows::winrm (
  $auth_basic   = true,
  $disable_http = true
) {

  class {'winrm_ssl':
    auth_basic     => $auth_basic,
    disable_http   => $disable_http,
    manage_service => true,
    maxtimeoutms   => 60000,
    maxmemorypershellmb => 2048
  }

}
