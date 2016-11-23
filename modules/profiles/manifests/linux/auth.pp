
class profiles::linux::auth (
  $enable = false,
  $domain = undef,
  $domain_join_user = undef,
  $domain_join_password = undef,
  $computer_ou='OU=Linux Computers',

){

  if $enable and empty($domain) {
    fail('The domain parameter cannot be an empty value if enable=true')
  }

  if $enable and empty($domain_join_user) {
    fail('The domain_join_user parameter cannot be an empty value if enable=true')
  }

  if $enable and empty($domain_join_password) {
    fail('The domain_join_password parameter cannot be an empty value if enable=true')
  }


  if $enable {

    # Note: if service wont start, reset sssd, your ptobably 
    # not joined to the domain:
    #       rm /etc/realmd.conf
    #       rm /etc/sssd/sssd.conf
    #       rm -f /var/lib/sss/mc/*
    #       rm -f /var/lib/sss/db/*


    class { '::realmd':
      domain               => $domain,
      domain_join_user     => $domain_join_user,
      domain_join_password => $domain_join_password,
      realmd_config => {
        "$domain" => {
          'computer-ou' => $computer_ou,
        },
      },

      manage_sssd_config => true,
      sssd_config        => {
        'sssd' => {
          'domains'             => $domain,
          'config_file_version' => '2',
          'services'            => 'nss,pam',
        },
        "domain/${domain}" => {
          'ad_domain'                      => $domain,
          'krb5_realm'                     => upcase($domain),
          'realmd_tags'                    => 'manages-system joined-with-adcli',
          'cache_credentials'              => 'True',
          'id_provider'                    => 'ad',
          'access_provider'                => 'ad',
          'krb5_store_password_if_offline' => 'True',
          'default_shell'                  => '/bin/bash',
          'ldap_id_mapping'                => 'True',
          'fallback_homedir'               => '/home/%d/%u',
          'use_fully_qualified_names'      => 'False',
        },
      },
      manage_krb_config  => true,
      krb_config => {
        'logging' => {
          'default' => 'FILE:/var/log/krb5libs.log',
        },
        'libdefaults' => {
          'default_realm'    => upcase($domain),
          'dns_lookup_realm' => true,
          'dns_lookup_kdc'   => true,
          'kdc_timesync'     => '0',
        },
      }
    }
  } else {
    #notify {"Info: profiles::linux::auth::enable is false":}
    }
}
