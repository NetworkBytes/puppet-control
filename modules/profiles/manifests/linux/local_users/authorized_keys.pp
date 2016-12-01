define profiles::linux::local_users::authorized_keys (
  String $user = $title,
  String $group,
  String $authorized_keys_base = hiera('profiles::linux::authorized_keys::authorized_keys_base')
) {

  # read in hiera class_name/$group.yaml
  $hiera_file=$group

  $directory_defaults = {
    ensure => 'directory',
    mode   => '0644',
    owner  => 'root',
    group  => 'root'
  }
  # create the base directorye
  ensure_resource('file', $authorized_keys_base, $directory_defaults)


  $ssh_authorized_keys = hiera_hash('profiles::linux::local_users::authorized_keys', false)
  $ssh_authorized_keys_defaults = {
    ensure => present,
    target => "$authorized_keys_base/$user/authorized_keys"
  }

  if $ssh_authorized_keys {

    $ssh_authorized_keys.each | String $auth_title, $auth_hash | {
      if ("${auth_hash[user]}" == $user ) {
        #notify {"match $user ${auth_title} = ${auth_hash[user]}":}
        $filepath_hash = {"$authorized_keys_base/$user" => {owner => $user}}
        create_resources ( 'file', $filepath_hash , $directory_defaults )
        create_resources ( 'ssh_authorized_key', {$auth_title => $auth_hash}, $ssh_authorized_keys_defaults )
      }
    }


  } else {
    #notify {"Info: $user: no ssh_authorized_keys hash found in hiera for this node, not managing any ssh auth keys":}
  }
}


