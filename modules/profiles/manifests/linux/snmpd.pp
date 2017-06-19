
class profiles::linux::snmpd (
  String  $ro_community,
  String  $ro_network,
  String  $contact,
  String  $location,
) {

  # requires 'razorsedge/snmp'
  class {'::snmp':
    views        => [ 'systemview included .1.3.6.1.2.1.1',
                      'systemview included .1.3.6.1.2.1.25.1.1',
                      'systemview included .1' ],
    contact      => $contact,
    location     => $location,

    agentaddress => [ 'udp:0.0.0.0:161' ],
    ro_community => $ro_community,
    ro_network   => $ro_network,
    com2sec      => ["notConfigUser  default       $ro_community"],
  }

}
