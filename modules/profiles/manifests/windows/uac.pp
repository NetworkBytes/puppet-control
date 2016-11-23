class profiles::windows::uac (
  $ensure
) {

  validate_re($ensure, '^(present|enabled|absent|disabled)$', 'valid values for ensure are \'present\', \'enabled\', \'absent\', \'disabled\'')
  
  $data = $ensure ? { /(present|enabled)/ => 1, /(absent|disabled)/ => 0}


  $regbase   = 'HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System'

  registry::value{'UAC':
    key    => $regbase,
    value  => 'EnableLUA',
    type   => 'dword',
    data   => $data,
  }
  reboot {'UAC':
    subscribe => Registry::Value['UAC'],
    apply  => finished,
  }
}
