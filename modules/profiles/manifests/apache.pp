
 class profiles::apache {
  include 'profiles::apache::base'
  include 'profiles::apache::modules'
  include 'profiles::apache::vhosts'
}

