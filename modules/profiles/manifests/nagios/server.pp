class profiles::nagios::server {


#profiles::nagios::server::commands:
#  check_nrpe_<REDACTED>:
#    command_line: "${nrpe} -c check_<REDACTED>"


  # Add check command to /etc/nagios/nagios_command.cfg
#  @@nagios_command { "check_nrpe_<REDACTED>":
#   command_line => "${nrpe} -c check_<REDACTED> $command_parameters",
#    command_line => "${nrpe} -c check_<REDACTED>",
#    tag          => regsubst($server,'^(.+)$','nagios-\1'),
#  }


  # Create all resources for nagios types
  #create_resources (nagios_command, $commands)
  #create_resources (nagios_contact, $contacts)
  #create_resources (nagios_contactgroup, $contactgroups)
  #create_resources (nagios_host, $hosts)
  #create_resources (nagios_hostdependency, $hostdependencies)
  #create_resources (nagios_hostgroup, $hostgroups)
  #create_resources (nagios_service, $services)
  #create_resources (nagios_servicegroup, $servicegroups)
  #create_resources (nagios_timeperiod, $timeperiods)




  class { '::nagios::server':
    nagios_server => hiera('profiles::nagios::server'),
    apache_httpd  => false,
    php           => false
  }

  $server              = $::nagios::client::server


}

