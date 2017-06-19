
class profiles::haproxy::frontend (

) {

  $haproxy_frontends = hiera_hash('profiles::haproxy::frontends', false)
  $haproxy_frontends_defaults = {
    mode          => 'http',
    #bind_options  => 'accept-proxy',
  }

  if $haproxy_frontends {
    create_resources ( 'haproxy::frontend', $haproxy_frontends, $haproxy_frontends_defaults )
  } else {
    #notify {"Info: no profiles::haproxy::frontends hash found in hiera for this node, not managing haproxy frontends":}
  }

}

