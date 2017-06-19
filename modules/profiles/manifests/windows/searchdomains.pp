
#Manage DNS search domain suffix
class profiles::windows::searchdomains(
  $searchlist
) {

  #TODO

  validate_array($searchlist)
  $list = join($searchlist, ',')

  registry::value{'Windows DNS Suffix Search Order':
    key   => 'hklm\system\CurrentControlSet\Services\TCPIP\Parameters',
    value => 'SearchList',
    data  => $list,
  }

}
