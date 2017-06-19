
# SELINUX
class profiles::linux::selinux (
  $mode,
  $type = "targeted",

) {

  class { selinux:
    mode => $mode,
    type => $type,
  }


  # SELINUX BOOLS
  $selinux_bools = hiera_hash('profiles::linux::selinux::bools', false)
  $selinux_bools_defaults={
  }

  if $selinux_bools {
    create_resources ( 'selinux::boolean', $selinux_bools, $selinux_bools_defaults )
  } else {
    #notify {"Info: no profiles::linux::selinux::bools hash found in hiera for this node":}
  }



  # SELINUX PORTS
  $selinux_ports = hiera_hash('profiles::linux::selinux::ports', false)
  $selinux_ports_defaults={
  }

  if $selinux_ports {
    create_resources ( 'selinux::port', $selinux_ports, $selinux_ports_defaults )
  } else {
    #notify {"Info: no profiles::linux::selinux::ports hash found in hiera for this node":}
  }



  # SELINUX FCONTEXT
  $selinux_fcontexts = hiera_hash('profiles::linux::selinux::fcontexts', false)
  $selinux_fcontext_defaults={
  }

  if $selinux_fcontexts {
    create_resources ( 'selinux::fcontext', $selinux_fcontexts, $selinux_fcontext_defaults )
  } else {
    #notify {"Info: no profiles::linux::selinux::fcontexts hash found in hiera for this node":}
  }
}
