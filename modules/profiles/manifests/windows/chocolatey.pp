# Class to install chocolatey since not all nodes are connected to the internet

class profiles::windows::chocolatey (
  $chocolateypkg      = "https://chocolatey.org",
  $chocolateyversion, # 0.9.9.8
  $zipurl             = "https://chocolatey.org/7za.exe",

){

  #TODO: -  work out if the community module supports a local install script

  $chocolatey_ver_file = "C:\\ProgramData\\Chocolatey\\version-$chocolateyversion.txt"
  exec { "install-chocolatey":
    creates   => $chocolatey_ver_file,
    provider  => powershell,
    logoutput => true,
    command   => template("$module_name/windows/chocolatey/install.ps1.erb"),
  }

  file {$chocolatey_ver_file:
    ensure  => present,
    require => Exec["install-chocolatey"],
  }

}

