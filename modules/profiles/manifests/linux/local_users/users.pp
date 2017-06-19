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
