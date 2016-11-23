class profiles::puppet::agent {

  service { 'puppet':
    ensure => running,
    enable => true
  }


  include 'profiles::puppet::agent::conf'

}


class profiles::puppet::agent::conf {

  case $::osfamily {
    'Windows': { $file = 'c:/ProgramData/PuppetLabs/puppet/etc/puppet.conf'}
    default: {
      # Assumes > v4 puppet agent
      $file = '/etc/puppetlabs/puppet/puppet.conf'
    }
  }

  case $::host['environment'] {
    #/[Pp][Rr][Oo][Dd]/:   { $env = 'production' }
    /[Uu][Aa][Tt]/:       { $env = 'uat' }
    /[Tt][Ee][Ss][Tt]/:   { $env = 'test' }
    /[Dd][Ee][Vv]/:       { $env = 'develop' }
    default:  { $env = 'production' }
  }
  
  
 
  #notify {"WARNING: Puppet environment will change to $env on the next run, updating $file":}
  
  file_line { "puppet-agent $file":
    ensure => present,
    path => $file,
    match => "^\s*environment\s*=.*$",
    line => "environment = $env"
  }
  
  #file_line { "puppet-agent $file":
  #  ensure => absent,
  #  path => $file,
  #  match => "^\s*environment\s*=.*$",
  #  line => "environment = $env"
  #}


}

