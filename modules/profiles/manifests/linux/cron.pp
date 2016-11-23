
# CRON
class profiles::linux::cron (
  Boolean $purge = true
) {

  $linux_cron = hiera_hash('profiles::linux::cron', false)
  $linux_cron_defaults = {
  }

  if $linux_cron {
    create_resources ( 'cron', $linux_cron, $linux_cron_defaults )
  } else {
    notify {"Info: no profiles::linux::cron hash found in hiera for this node, not managing crontabs":}
  }

  # Purge unmanage entries
  resources {'cron':
    purge => $purge,
    #noop  => true,
  }
}

