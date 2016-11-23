# DEFAULT PACKAGES
class profiles::windows::firewall (
  $ensure = 'running',
) {

  validate_re($ensure, '^(running|stopped)$', 'valid values for ensure are \'running\', \'stopped\'')

  class {'windows_firewall':
    ensure => $ensure
  }

  $windows_firewall = hiera_hash('profiles::windows::firewall::exception', false)
  $windows_firewall_defaults = {
    ensure       => present,
    direction    => 'in',
    action       => 'allow',
    enabled      => 'yes',
    protocol     => 'TCP',
  }

  if $windows_firewall{
    create_resources ( 'windows_firewall::exception', $windows_firewall, $windows_firewall_defaults )
  } else {
    notify {"Info: no profiles::windows::firewall::exception hash found in hiera for this node":}
  }
}

