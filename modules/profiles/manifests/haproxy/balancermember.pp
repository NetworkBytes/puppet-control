
class profiles::haproxy::balancermember (

) {

  $haproxy_balancermembers = hiera_hash('profiles::haproxy::balancermembers', false)
  $haproxy_balancermembers_defaults = {
    options           => 'check',
  }

  if $haproxy_balancermembers {
    create_resources ( 'haproxy::balancermember', $haproxy_balancermembers, $haproxy_balancermembers_defaults )
  } else {
    #notify {"Info: no profiles::haproxy::balancermembers hash found in hiera for this node, not managing haproxy balancemembers":}
  }


}
