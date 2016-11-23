
class profiles::haproxy::backend (

) {

  $haproxy_backends = hiera_hash('profiles::haproxy::backends', false)
  $haproxy_backends_defaults = {
  }

  if $haproxy_backends {
    create_resources ( 'haproxy::backend', $haproxy_backends, $haproxy_backends_defaults )
  } else {
    #notify {"Info: no profiles::haproxy::backends hash found in hiera for this node, not managing haproxy backends":}
  }

}

