
class profiles::apache::modules {

  $mods = hiera_array('profiles::apache::modules', false)

  if $mods {
    $mods.each |String $mod | {
      include "::apache::mod::$mod"
    }
  }
}
