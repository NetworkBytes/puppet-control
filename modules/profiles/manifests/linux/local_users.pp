
# LOCAL USERS
class profiles::linux::local_users (
  Boolean $purge = true
){
  # list of users groups to add to catalog
  $include_users_in_group = hiera_array('profiles::linux::local_users::include_users_in_group', [])

  # loop all groups of users to add
  $include_users_in_group.each |String $group| {
    profiles::linux::local_users::users {$group:}
  }

  if $purge {
    # Purge any users not managed by puppet
    resources {
      'user':
        purge => true,
        unless_system_user => true,
        #noop  => true,
    }  
  }
}

define profiles::linux::local_users::users (
  $group = $title,
) {
  # read in hiera class_name/$group.yaml
  $hiera_file=$group

  # Additional groups for users in group $group
  $hash_groups = hiera_hash('profiles::linux::local_users::additional_groups', {})
  if !empty($hash_groups) and has_key($hash_groups, $group) {
      $groups = $hash_groups[$group]
  } else {
    $groups = []
  }


  # User Defaults
  $user_defaults = {
    ensure     => present,
    membership => 'inclusive',
    managehome => true,
    gid        => $group,
    groups     => $groups,
    require    => Group[$group],
    #purge_ssh_keys => true,
  }
  
  $users = hiera_hash("linux_users_$group", {})
  if !empty($users) {
    #create_resources ( 'user', $users, $user_defaults )
    $users.each |$user_title, $user_hash| {

      # create individual user resource
      create_resources ( 'user', {$user_title => $user_hash}, $user_defaults )

      # add users ssh keys 
      profiles::linux::local_users::authorized_keys{$user_title: group=>$group}
    }

  } else {
    notify {"Info: no users for group: $group.":}
  }
}




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


