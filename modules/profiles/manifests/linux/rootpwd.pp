
# ROOT PASSWORD
class profiles::linux::rootpwd (
  $password
) {

  # get root password from hiera
  #$root_pwd = hiera('root_pwd', false)

  #if $password {
    user { 'root_password': 
      name => 'root',
      password => $password,
    }
  #} else {
  #  notify {"Info: no root_pwd found in hiera for this node, not managing root password":}
  #}

}


