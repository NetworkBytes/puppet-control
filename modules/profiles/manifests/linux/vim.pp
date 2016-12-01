
# VIM
class profiles::linux::vim {


  $linux_vim = hiera_array('profiles::linux::vim::options', false)

  if $linux_vim {
    class {'vim':
      opt_misc => $linux_vim,
    }
  } else {
    include 'vim'
    #notify {"Info: no profiles::linux::vim::options array found in hiera for this node, not managing yum repositories":}
  }

}
  
