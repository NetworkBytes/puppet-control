# DEFAULT PACKAGES
class profiles::windows::packages (
  $chocolatey_source
) {

  $packages_windows = hiera_hash('profiles::windows::packages', false)
  $package_defaults = {
    ensure   => present,
    provider => chocolatey,
    source   => $chocolatey_source,
    require  => Class['profiles::windows::chocolatey'],
  }

  if $packages_windows {
    create_resources ( 'package', $packages_windows, $package_defaults )
  } else {
    notify {"Info: no profiles::windows::packages hash found in hiera for this node":}
  }
}

