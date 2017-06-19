class profiles::windows::ie_enhanced_security (
  $ensure
) {

  $val = $ensure ? { /(present|enabled)/ => 1, /(absent|disabled)/ => 0}

  $regbase   = 'HKLM\Software\Microsoft\Active Setup\Installed Components'
  registry_value { "$regbase\\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}":
    type => dword,
    data => $val
  }

}


