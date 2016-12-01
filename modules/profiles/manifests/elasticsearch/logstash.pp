
class profiles::elasticsearch::logstash {

  class {'logstash':
     #install_contrib => true
  }

# INPUTS
$config_rsyslog_input='
input {
  file {
    type => "syslog"
    path => ["/var/log/rsyslog/**/*"]
  }
}'


#FILTER
$config_rsyslog_filter_sample='
# Sample
#       "message" => "2016-03-22T14:55:01.440366+11:00 <REDACTED> crond[24406]: (<REDACTED>) CMD ($HOME/scripts/cron/<REDACTED> >/dev/null 2>&1)",
#      "@version" => "1",
#    "@timestamp" => "2016-03-22T03:56:33.421Z",
#          "path" => "/var/log/rsyslog/172.26.14.132/2016/03/22/messages",
#          "host" => "dev2-syslog1-1.dev2",
#          "type" => "syslog",
#          "tags" => [
#        [0] "_grokparsefailure"'


#FILTER
$config_rsyslog_filter='
filter {
  if [type] == "syslog" {
    #grok {
    #  match => { "message" => "%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}" }
    #  add_field => [ "received_at", "%{@timestamp}" ]
    #  add_field => [ "received_from", "%{host}" ]
    #}
    #date {
    #  match => [ "syslog_timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
    #}
  }
}'

#OUTPUT
$config_output='
output {
  elasticsearch { hosts => ["localhost:9200"] }
  #stdout { codec => rubydebug }
}'


  logstash::configfile { 'config_rsyslog_input':
    content => $config_rsyslog_input
  }

  logstash::configfile { 'config_rsyslog_filter_sample':
    content => $config_rsyslog_filter_sample
  }


  logstash::configfile { 'config_rsyslog_filter':
    content => $config_rsyslog_filter
  }

  logstash::configfile { 'config_output':
    content => $config_output
  }


}

