
class profiles::elasticsearch::elasticsearch {

  class {'elasticsearch':
    config => { 'cluster.name' => "es-cluster" }
  }

  # Setup instance 1
  elasticsearch::instance { "es-01":
    config => { 'node.name' => $::fqdn }
  }
}
