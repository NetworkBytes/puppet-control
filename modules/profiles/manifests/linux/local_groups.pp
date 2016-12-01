# LINUX GROUPS
class profiles::linux::local_groups (
  # need to add all required groups prior to purge
  $purge = false,
){

  if $purge {
    # Purge any groups not managed by puppet
    resources {
      'group':
        purge => true,
        unless_system_user => true,
        noop  => true,
    }
  }

  $linux_groups = hiera_hash('profiles::linux::local_groups', false)
  $linux_groups_defaults = {
    ensure => present,
  }

  if $linux_groups {
    create_resources ( 'group', $linux_groups, $linux_groups_defaults )
  } else {
    #notify {"Info: no profiles::linux::local_groups hash found in hiera for this node, not managing groups":}
  }
}
