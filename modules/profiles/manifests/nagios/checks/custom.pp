class profiles::nagios::checks::custom (
) {

  ### CHECK FROM CUSTOM MODULE NRPE ###

  # Gather Nagios checks from hiera
  $nagios_checks = hiera_hash('profiles::nagios::checks::custom', false)

  if $nagios_checks {
    # iterate hiera hash and add checks and nrpe config
    $nagios_checks.each |String $check_title, $check_hash  | {

      create_resources("class", {"::nrpe::check::$check_title" => $check_hash})

    }

  } else {
    #notify {"Info: no profiles::nagios::checks::custom hash found in hiera for this node":}
    }
}

