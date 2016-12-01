class profiles::oracle::client (
  $oracle_home,
  $crypto_seed,

  $datasource,
  $host,
  $port,
  $servicename,
  
) {

  file {"$oracle_home\\network\\admin\\sqlnet.ora":
    content => template("${module_name}/sqlnet.ora.erb"),
  }

  file {"$oracle_home\\network\\admin\\tnsnames.ora":
    content => template("${module_name}/tnsnames.ora.erb"),
  }
}
