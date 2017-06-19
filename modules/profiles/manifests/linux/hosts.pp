

# HOSTS
class profiles::linux::hosts (
  Boolean $purge = true
) {

  $linux_hosts = hiera_hash('profiles::linux::hosts', false)
  $linux_hosts_defaults = {
    ensure => present
  }

  if $linux_hosts {
    create_resources ( 'host', $linux_hosts, $linux_hosts_defaults )
  } else {
    notify {"Info: no profiles::linux::hosts hash found in hiera for this node, not managing host entries":}
  }

  # Purge unmanage entries
  resources {'host':
    purge => $purge,
    #noop  => true,
  }
}

