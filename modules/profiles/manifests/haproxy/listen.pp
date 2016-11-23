
class profiles::haproxy::listen (

) {

  $haproxy_listeners = hiera_hash('profiles::haproxy::listeners', false)
  $haproxy_listeners_defaults = {
    collect_exported => false,
  }

  if $haproxy_listeners {
    create_resources ( 'haproxy::listen', $haproxy_listeners, $haproxy_listeners_defaults )
  } else {
    #notify {"Info: no profiles::haproxy::listeners hash found in hiera for this node, not managing haproxy listeners":}
  }



}
