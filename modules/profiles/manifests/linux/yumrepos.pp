
# YUM REPOSITORIES
class profiles::linux::yumrepos {

  $linux_yumrepos = hiera_hash('profiles::linux::yumrepos::repos', false)
  $linux_yumrepos_defaults = {
    enabled  => 1,
    gpgcheck => 1
  }

  if $linux_yumrepos {
    create_resources ( 'yumrepo', $linux_yumrepos, $linux_yumrepos_defaults )
  } else {
    notify {"Info: no profiles::linux::yumrepos::repos hash found in hiera for this node, not managing yum repositories":}
  }
}
