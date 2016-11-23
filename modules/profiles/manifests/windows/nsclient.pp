class profiles::windows::nsclient
(
  $allowed_hosts,
  $allow_arguments = true,
  $package_install = false,
) {

  
  class { '::nsclient':
    package_install  => $package_install,
    allowed_hosts    => $allowed_hosts,
    allow_arguments  => $allow_arguments,
    external_scripts => hiera_array('profiles::windows::nsclient', []),
  }


  # copy external scripts
  include '::nsclient_files'

}
