
# SUDOERS
class profiles::linux::sudoers (
  $purge = true,
  $config_file_replace = true,

) {

  $linux_sudoers = hiera_hash('profiles::linux::sudoers', false)
  $linux_sudoers_defaults = {
    ensure   => present,
    priority => 10,
  }
  
  if $linux_sudoers {
    # sudo class
    class {'sudo':
      purge => $purge,
      config_file_replace => $config_file_replace
    }

    # sudo configs
    create_resources ( 'sudo::conf', $linux_sudoers, $linux_sudoers_defaults )
  } else {
    notify {"Info: no profiles::linux::sudoers hash found in hiera for this node":}
  }  
}
