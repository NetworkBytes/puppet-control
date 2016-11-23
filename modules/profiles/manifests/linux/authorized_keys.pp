class profiles::linux::authorized_keys(
  String $authorized_keys_base,
) {

  $directory_defaults = {
    ensure => 'directory',
    mode   => '0644',
    owner  => 'root',
    group  => 'root'
  }
  # create the base directorye
  ensure_resource('file', $authorized_keys_base, $directory_defaults)


  $ssh_authorized_keys = hiera_hash('profiles::linux::authorized_keys', false)
  $ssh_authorized_keys_defaults = {
    ensure => present,
  }

  if $ssh_authorized_keys {

    $ssh_authorized_keys.each | String $auth_title, $auth_hash | {
      $user = "${auth_hash[user]}"
      $auth_hash_merged = merge($auth_hash, {target => "$authorized_keys_base/$user/authorized_keys"})
      $filepath_hash = {"$authorized_keys_base/$user" => {owner => $user}}
      create_resources ( 'file', $filepath_hash , $directory_defaults )
      create_resources ( 'ssh_authorized_key', {$auth_title => $auth_hash_merged}, $ssh_authorized_keys_defaults )
    }

  } else {
    #notify {"Info: no ssh_authorized_keys hash found in hiera for this node, not managing any ssh auth keys":}
  }
}
