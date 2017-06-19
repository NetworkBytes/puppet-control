
class profiles::haproxy (

) {

  include 'profiles::haproxy::base'
  include 'profiles::haproxy::listen'
  include 'profiles::haproxy::balancermember'
  include 'profiles::haproxy::frontend'
  include 'profiles::haproxy::backend'

}
