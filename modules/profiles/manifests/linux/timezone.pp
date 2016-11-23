
# TIMEZONE
class profiles::linux::timezone (
  $zone
) {

  class {'timezone':
    timezone  => $zone,
  }

}
    
