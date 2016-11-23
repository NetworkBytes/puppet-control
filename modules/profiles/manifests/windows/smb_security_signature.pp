class profiles::windows::smb_security_signature (
  $ensure
) {
  validate_re($ensure, '^(present|enabled|absent|disabled)$', 'valid values for ensure are \'present\', \'enabled\', \'absent\', \'disabled\'')

  $data = $ensure ? { /(present|enabled)/ => 1, /(absent|disabled)/ => 0}

  $regbase   = 'HKLM\System\CurrentControlSet\Services\LanmanWorkstation\Parameters'
  registry_value { "$regbase\\RequireSecuritySignature":  
    type => dword, 
    data => "$data"
  }
}
