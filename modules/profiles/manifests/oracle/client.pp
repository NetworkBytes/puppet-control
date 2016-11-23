class profiles::oracle::client (
  $oracle_home,
  $crypto_seed,

  $<REDACTED>_datasource,
  $<REDACTED>_host,
  $<REDACTED>_port,
  $<REDACTED>_servicename,
  
) {

  file {"$oracle_home\\network\\admin\\sqlnet.ora":
    content => template("${module_name}/sqlnet.ora.erb"),
  }

  file {"$oracle_home\\network\\admin\\tnsnames.ora":
    content => template("${module_name}/tnsnames.ora.erb"),
  }
}
