
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
