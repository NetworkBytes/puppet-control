
class profiles::linux::sshd (
  $authorizedkeysfile
) {

  $allowgroups = hiera_array('profiles::linux::sshd::allowgroups')

  $groups = join($allowgroups, ' ')

  # SSH Keygen for ECDSA keys
  exec {'/usr/bin/ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key':
    unless => '/usr/bin/test -f /etc/ssh/ssh_host_ecdsa_key'
  }

  class { 'ssh::server':
    storeconfigs_enabled => false,
    options => {
      'Port'               => [22],
      'PasswordAuthentication' => 'yes',
      'PermitRootLogin'    => 'no',
      'AuthorizedKeysFile' => $authorizedkeysfile,
      'AcceptEnv'          => 'LANG LC_*',
      'Subsystem'          => 'sftp /usr/libexec/openssh/sftp-server',
      'UsePAM'             => 'yes',
      'AllowTcpForwarding' => 'no',
      'Banner'             => '/etc/issue',
      'LogLevel'           => 'info',
      'SyslogFacility'     => 'AUTHPRIV',
      'AllowGroups'        => $groups,
      'HostKey'            => [
        '/etc/ssh/ssh_host_rsa_key',
        '/etc/ssh/ssh_host_ecdsa_key',
       ],
      'ChallengeResponseAuthentication' => 'no',
      'GSSAPIAuthentication' => 'no',
      'GSSAPICleanupCredentials' => 'no',
      'Ciphers' => 'chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr',
      'MACs' => 'hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-ripemd160-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,hmac-ripemd160,umac-128@openssh.com',
      'AcceptEnv' => [
        'LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES',
        'LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT',
        'LC_IDENTIFICATION LC_ALL LANGUAGE',
        'XMODIFIERS',
      ],
    },
  }
}




