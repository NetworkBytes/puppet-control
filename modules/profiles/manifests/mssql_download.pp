class profiles::mssql_download
{ 
  $baseurl="http://files"
  $local_dir="c:/Source"
  $mount_point="Z:"

  # create the source directory if it doesnt already exist
  ensure_resource('file', "$local_dir", {'ensure' => 'directory'})

  download_file { "Download SQL 2012 ISO" :
    url => "$baseurl/Microsoft/SQL_Server/2012/SW_DVD9_SQL_Svr_Enterprise_Edtn_2012w_SP2_64Bit_English_-2_MLF_X19-74922.ISO",
    destination_directory => $local_dir,
    require => File["$local_dir"]
  }

  download_file { "Download SQL 2012 CU7" :
    url => "$baseurl/Microsoft/SQL_Server/2012/SQLServer2012-KB3072100-x64.exe",
    destination_directory => $local_dir,
    require => File["$local_dir"]
  }

  mount_iso { "$local_dir/SW_DVD9_SQL_Svr_Enterprise_Edtn_2012w_SP2_64Bit_English_-2_MLF_X19-74922.ISO":
    drive_letter => 'Z',
    require => Download_file["Download SQL 2012 ISO"]
  }

}
