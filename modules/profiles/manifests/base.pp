# MAIN ENTRY POINT
# for Base modules
class profiles::base (
  Boolean $include_base = true
){
  if $include_base {
    case $kernel {
      'windows': { include profiles::windows::base }
      'Linux':   { include profiles::linux::base   }
    }
  }
}

