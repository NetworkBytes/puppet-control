
class profiles::rsyslog::client (
  $server,
  $log_local = true
){

 class { 'rsyslog::client':
    log_remote                => true,
    log_local                 => $log_local,
    server                    => $server,
    rate_limit_interval       => 0,
    #custom_config             => 'profiles/rsyslog_systemd.erb'
  }
}

