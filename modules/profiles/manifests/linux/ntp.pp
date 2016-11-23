
class profiles::linux::ntp (
  $servers
) {

  class { '::ntp':
    servers => $servers,
  }

  #
  # vmware toolbox returns 69 from vmware-toolbox-cmd timesync status if it's disabled
  #   it returns 0 if it's enabled
  #

  #TODO used fact to test for VM flavour
  exec { "Disable vmware timesync":
    command   => "/usr/bin/vmware-toolbox-cmd timesync disable",
    onlyif   => "/usr/bin/vmware-toolbox-cmd timesync status"
  }

}




