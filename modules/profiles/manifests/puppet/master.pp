class profiles::puppet::master {


  #TODO: trigger a reboot of service
  #  file_line { 'Puppet_dashboard_timezone_settings':
  #    path  => '/etc/puppetlabs/puppet-dashboard/settings.yml',
  #    match => "^.*time_zone:.*$",
  #    line => "$time_zone: 'Sydney'"
  #  }

}

