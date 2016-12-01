
# RESOLVCONF /etc/resolv.conf
class profiles::linux::resolvconf (
  #$domainname,
  $searchpath,
  $nameservers
) {

  # man resolv.conf(5)
  #  The domain and search keywords are mutually exclusive.  If more than
  #  one instance of these keywords is present, the last instance wins.


  class {'resolv_conf':
    #domainname  => $domainname,
    searchpath  => $searchpath,
    nameservers => $nameservers
  }

}

