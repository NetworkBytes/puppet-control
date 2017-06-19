
# DISABLE IPV6
class profiles::linux::ipv6 (
  Boolean $enabled = true
) {

  ensure_resource('file', '/etc/sysctl.d', {
    ensure => directory,
    mode => '0755'
  })

  $val = bool2num($enabled)
  file {'/etc/sysctl.d/01-disableipv6.conf':
    ensure  => file,
    content => "net.ipv6.conf.all.disable_ipv6 = $val"
  }
}




