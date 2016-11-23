class profiles::windows::rpc (
  $range = ["5001-5200"]
) {

  $regbase   = 'HKLM\Software\Microsoft\Rpc'
  registry_key {"$regbase\\Internet": ensure => present}

  registry_value { "$regbase\\Internet\\Ports":  
    type => array, 
    data => $range
  } 

  registry_value { "$regbase\\Internet\\PortsInternetAvailable":  
    type => string, 
    data => "Y"
  } 

  registry_value { "$regbase\\Internet\\UseInternetPorts":  
    type => string, 
    data => "Y"
  }
}

