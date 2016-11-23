class profiles::nagios::client (
  $nrpe_dont_blame_nrpe = 1,
) {

  $hosts = "${join(hiera_array('profiles::nagios::client::allowed_hosts', ['127.0.0.1']), ',')}"
 
  # Configure NRPE.cfg
  class {'::nagios::client':
    nagios_server        => hiera('profiles::nagios::server'),
    nrpe_dont_blame_nrpe => $nrpe_dont_blame_nrpe,
    nrpe_allowed_hosts   => $hosts,
    host_check_command   => 'check_nrpe_users', #ICMP disabled
    selinux              => false, #not manage selinux
    defaultchecks        => false
  }

  # copy custom scripts to lib/custom directory
  include ::nrpe

  # add all the checks for client
  # builtin = builtin into the nagios module
  # custom = check added by our custom nrpe module
  include ::profiles::nagios::checks::builtin
  include ::profiles::nagios::checks::custom

}

