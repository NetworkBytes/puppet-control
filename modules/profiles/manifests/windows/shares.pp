# WINDOWS SHARES
class profiles::windows::shares {

  $windows_shares = hiera_hash('profiles::windows::shares', false)
  $windows_shares_defaults = {
    ensure       => present,
    maximumusers => unlimited,
    cache        => none
  }

  if $windows_shares{
    create_resources ( 'net_share', $windows_shares, $windows_shares_defaults )
  } else {
    #notify {"Info: no profiles::windows::share hash found in hiera for this node":}
  }
}

