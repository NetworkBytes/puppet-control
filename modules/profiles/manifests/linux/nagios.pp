
BREAKME

# Not Used with the community module

class  profiles::linux::nagios (
  Boolean $manage_firewall = false
) {
  include 'profiles::linux::nagios::nrpe'
  include 'profiles::linux::nagios::export'
}


# NRPE
class  profiles::linux::nagios::nrpe (
  $allowed_hosts
) {
  class {'nagios::nrpe':
    #manage_firewall => $manage_firewall,
    allowed_hosts   => $allowed_hosts
  }
}

# NAGIOS EXPORTED RESOURCES
class  profiles::linux::nagios::export {
  include 'nagios::export'
}

