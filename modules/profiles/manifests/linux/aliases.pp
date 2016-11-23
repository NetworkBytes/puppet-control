
# ALIASES /etc/aliases
class profiles::linux::aliases {

  $linux_aliases = hiera_hash('profiles::linux::aliases', false)
  $linux_aliases_defaults = {}
  
  if $linux_aliases {
    create_resources ( 'linux_aliases', $linux_aliases, $linux_aliases_defaults )
  } else {
    notify {"Info: no linux_aliases hash found in hiera for this node, no managing /etc/aliases":}
  }  
}
