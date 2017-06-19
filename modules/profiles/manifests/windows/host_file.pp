# HOST ENTRIES
class profiles::windows::host_file {

  $windows_hostfile = hiera_hash('profiles::windows::host_file', false)
  $windows_hostfile_defaults = {
    ensure => present,
    path   => 'C:/Windows/System32/drivers/etc/hosts',
  }

  if $windows_hostfile {
    create_resources ( 'file_line', $windows_hostfile, $windows_hostfile_defaults )
  } else {
    #notify {"Info: no profiles::windows::host_file hash found in hiera for this node":}
  }
}

