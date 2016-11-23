
class profiles::linux::directories {

  $linux_directories = hiera_hash('profiles::linux::directories', false)
  $linux_directory_defaults = {
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
  }

  if $linux_directories {
    $linux_directories.each |String $dir_title, $dir_hash  | {
      create_resources ( 'file', {$dir_title => $dir_hash }, $linux_directory_defaults )
    }
  } else {
    #notify {"Info: no profiles::linux::directories hash found in hiera for this node":}
  }
}
