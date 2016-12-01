# Remote Desktop Module
class profiles::windows::rdp (
  Boolean $enable,
  Boolean $enable_nla = false
) {

  $regbase   = 'HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server'

  # Terminal Server - User Config Errors
  registry_value { "$regbase\\IgnoreRegUserConfigErrors":
    type   => dword,
    data   => 1,
  }

  # Terminal Server - Deny Connections
  registry_value { "$regbase\\fDenyTSConnections":
    type   => dword,
    data   => $enable ? { true => "0", false => "1"},
  }

  # Terminal Server - NLA
  registry_value { "$regbase\\WinStations\\RDP-Tcp\\UserAuthentication":
    type   => dword,
    data  => bool2num($enable_nla),
  }

}

