
# DEFAULT PACKAGES
class profiles::linux::packages {

  # Packages all require proxy access
  Package {
    require => Class['profiles::linux::proxy'],
  }

  $packages_linux = hiera_hash('profiles::linux::packages', false)
  $package_defaults = {
    ensure => present,
    provider => yum,
  }

  if $packages_linux {
    create_resources ( 'package', $packages_linux, $package_defaults )
  } else {
    notify {"Info: no profiles::linux::packages hash found in hiera for this node":}
  }
}
