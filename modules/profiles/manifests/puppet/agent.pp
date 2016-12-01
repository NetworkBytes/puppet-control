class profiles::puppet::agent {

  service { 'puppet':
    ensure => running,
    enable => true
  }


  include 'profiles::puppet::agent::conf'

}
