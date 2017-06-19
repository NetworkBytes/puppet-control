
# ISSUE LOGIN MESSAGE
class profiles::linux::login_banner {

  file {'/etc/issue':
    ensure  => file,
    mode    => '0644',
    content => template("$module_name/issue.erb")
  }

}




