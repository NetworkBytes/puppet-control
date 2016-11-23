# DEFAULT PACKAGES
class profiles::windows::windowsfeatures {

  $windows_features = hiera_hash('profiles::windows::windowsfeatures', false)
  $windows_features_defaults = {
    ensure   => present,
    #installmanagementtools => true, #TODO:  requires 2012 or greater
    restart => true
  }

 if $::kernelversion =~ /^6.0/ { fail('Windows 2008 (non R2), use ServerManagerCMD.exe') }
  

  if $windows_features {
    create_resources ( 'windowsfeature', $windows_features, $windows_features_defaults )
  } else {
    #notify {"Info: no profiles::windows::iwindowsfeatures hash found in hiera for this node":}
  }
}

