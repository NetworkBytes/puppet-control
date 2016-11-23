class profiles::linux::base (
  Boolean $include_proxy        = true,
  Boolean $include_yumrepos     = true,
  Boolean $include_packages     = true,
  Boolean $include_sudoers      = true,
  Boolean $include_rootpwd      = true,
  Boolean $include_aliases      = true,
  Boolean $include_ipv6         = true,
  Boolean $include_login_banner = true,
  Boolean $include_resolvconf   = true,
  Boolean $include_local_groups = true,
  Boolean $include_local_users  = true,
  Boolean $include_ntp          = true,
  Boolean $include_certs        = true,
  Boolean $include_snmpd        = true,
  Boolean $include_sshd         = true,
  Boolean $include_authorized_keys = true,
  Boolean $include_directories  = true,
  Boolean $include_firewall     = true,
  Boolean $include_cron         = true,
  Boolean $include_hosts        = true,
  Boolean $include_selinux      = true,
  Boolean $include_timezone     = true,
  Boolean $include_vim          = true,
  Boolean $include_mcafee       = true,
  Boolean $include_auth         = true,

  Boolean $include_rsyslog_client = true,

  Boolean $include_puppet_agent = true,
  Boolean $include_nagios_client = true,
  Boolean $include_epel         = true

) {

  if $include_proxy        { include profiles::linux::proxy }
  if $include_yumrepos     { include profiles::linux::yumrepos }
  if $include_packages     { include profiles::linux::packages }
  if $include_sudoers      { include profiles::linux::sudoers }
  if $include_rootpwd      { include profiles::linux::rootpwd }
  if $include_aliases      { include profiles::linux::aliases }
  if $include_ipv6         { include profiles::linux::ipv6 }
  if $include_login_banner { include profiles::linux::login_banner }
  if $include_resolvconf   { include profiles::linux::resolvconf }
  if $include_local_groups { include profiles::linux::local_groups }
  if $include_local_users  { include profiles::linux::local_users }
  if $include_ntp          { include profiles::linux::ntp }
  if $include_certs        { include profiles::linux::certs }
  if $include_snmpd        { include profiles::linux::snmpd }
  if $include_sshd         { include profiles::linux::sshd }
  if $include_authorized_keys { include profiles::linux::authorized_keys }
  if $include_directories  { include profiles::linux::directories }
  if $include_firewall     { include profiles::linux::firewall }
  if $include_cron         { include profiles::linux::cron }
  if $include_hosts        { include profiles::linux::hosts }
  if $include_selinux      { include profiles::linux::selinux }
  if $include_timezone     { include profiles::linux::timezone }
  if $include_vim          { include profiles::linux::vim }
  if $include_mcafee       { include profiles::linux::mcafee }
  if $include_auth         { include profiles::linux::auth }

  if $include_rsyslog_client { include profiles::rsyslog::client }

  if $include_puppet_agent  { include profiles::puppet::agent }
  if $include_nagios_client { include profiles::nagios::client }
  if $include_epel          { include epel }
}
