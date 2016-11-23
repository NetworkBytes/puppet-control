
class profiles::elasticsearch::kibana (
  $running            = true,
  $enabled            = true,
){

  service { 'kibana':
    ensure     => $running,
    enable     => $enabled,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['kibana']
  }

}
