class profiles::windows::base (
  Boolean $include_host_file     = true,
  Boolean $include_searchdomains = true,
  Boolean $include_proxy         = true,
  Boolean $include_chocolatey    = true,
  Boolean $include_packages      = true,
  Boolean $include_windowsfeatures = true,
  Boolean $include_ie_enhanced_security = true,
  Boolean $include_rdp           = true,
  Boolean $include_ipv6          = true,
  Boolean $include_loopback_check = true,
  Boolean $include_smb_security_signature = true,
  Boolean $include_uac           = true,
  Boolean $include_hibernate     = true,
  Boolean $include_nsclient      = true,
  Boolean $include_shares        = true,
  Boolean $include_firewall      = true,
  Boolean $include_winrm         = true,
  Boolean $include_rpc           = true,

  Boolean $include_puppet_agent  = true,

  Boolean $include_<REDACTED>_certificates = true,
  Boolean $include_<REDACTED>_localsecuritypolicy = true

) {

  #TODO
  #if $include_searchdomains { include profiles::windows::searchdomains }
  if $include_host_file  { include profiles::windows::host_file }
  if $include_proxy      { include profiles::windows::proxy }
  if $include_chocolatey { include profiles::windows::chocolatey }
  if $include_packages   { include profiles::windows::packages }
  if $include_windowsfeatures       { include profiles::windows::windowsfeatures }
  if $include_ie_enhanced_securitiy { include profiles::windows::ie_enhanced_security }
  if $include_rdp        { include profiles::windows::rdp }
  if $include_ipv6       { include profiles::windows::ipv6 }
  if $include_loopback_check { include profiles::windows::loopback_check }
  if $include_smb_security_signature { include profiles::windows::smb_security_signature }
  if $include_uac        { include profiles::windows::uac }
  if $include_hibernate  { include profiles::windows::hibernate }
  if $include_nsclient   { include profiles::windows::nsclient }
  if $include_shares     { include profiles::windows::shares }
  if $include_firewall   { include profiles::windows::firewall }
  if $include_winrm      { include profiles::windows::winrm }
  if $include_rpc        { include profiles::windows::rpc }


  if $include_puppet_agent   { include profiles::puppet::agent }

  
  #TODO below
  if $include_<REDACTED>_certificates { include <REDACTED>::certificates }

  #if $include_<REDACTED>_localsecuritypolicy { include <REDACTED>::localsecuritypolicy }

  # push all monitoring via nsclient 
  ##   winconfig::snmp {"$title": ensure => 'enabled', community => 'readonly', permittedmanagers => '<REDACTED>' }

}

