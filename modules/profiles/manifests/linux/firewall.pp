class profiles::linux::firewall (
  $zone   = 'puppet_managed',
  $enable = true,
  $ensure = 'running'
){


  # define the zone
  firewalld_zone { $zone:
    ensure           => present,
    target           => '%%REJECT%%',
    purge_rich_rules => true,
    purge_services   => true,
    purge_ports      => true,
    icmp_blocks      => [] #['echo-request', 'echo-reply']
  }



  # FIREWALLD SERVICES
  $firewalld_services = hiera_hash('profiles::linux::firewall::services', false)
  $firewalld_services_defaults = {
    ensure  => 'present',
    zone    => $zone
  }

  if $firewalld_services {
    create_resources ( 'firewalld_service', $firewalld_services, $firewalld_services_defaults )
  } else {
    notify {"Info: no profiles::linux::firewall::services hash found in hiera for this node":}
  }



  # FIREWALLD PORTS
  $firewalld_ports = hiera_hash('profiles::linux::firewall::ports', false)
  $firewalld_ports_defaults = {
    ensure   => 'present',
    zone     => $zone,
    protocol => 'tcp',
  }

  if $firewalld_ports {
    create_resources ( 'firewalld_port', $firewalld_ports, $firewalld_ports_defaults )
  } else {
    notify {"Info: no profiles::linux::firewall::ports hash found in hiera for this node":}
  }



  class {'firewalld':
    package       => 'firewalld',
    package_ensure => 'installed',
    service_ensure => $ensure,
    service_enable => $enable,
    #zones          => {},
    #ports          => {},
    #services       => {},
    #rich_rules     => {},
  }


  # Set the default zone
  if $enable {
    exec { "firewall-cmd --set-default-zone $zone":
      path   => $path,
      unless => "firewall-cmd --get-default-zone|grep $zone"
    }
  }

}
