class profiles::linux::proxy {
  include 'profiles::linux::proxy::yum'
  include 'profiles::linux::proxy::profiles'
}
