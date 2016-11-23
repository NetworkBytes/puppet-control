
class profiles::linux::mcafee(
  $package_source,
) {

  class {'linux_mcafee':
    package_source => $package_source
  }
  
}
