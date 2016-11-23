class profiles::rsyslog::server (
  String $server_dir
){

  class { 'rsyslog::server':
    server_dir                => $server_dir,
    enable_onefile            => false,
    high_precision_timestamps => true,
    custom_config             => 'rsyslog/server-hostname.conf.erb',
    rotate                    => 'day',
    perm_file                 => '0604',
    perm_dir                  => '0754',
  }
  
}

