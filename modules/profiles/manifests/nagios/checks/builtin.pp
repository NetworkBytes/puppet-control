class profiles::nagios::checks::builtin (
) {

  ### CHECK BUILTING INTO THE MODULE ###

  # Gather Nagios checks from hiera
  $nagios_checks = hiera_hash('profiles::nagios::checks::builtin', false)

  if $nagios_checks {
    # iterate hiera hash and add checks and nrpe config
    $nagios_checks.each |String $check_title, $check_hash  | {

      create_resources("class", {"::nagios::check::$check_title" => $check_hash})

    }

  } else {
    #notify {"Info: no profiles::nagios::checks::builtin hash found in hiera for this node":}
    }
}

