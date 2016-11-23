require 'facter'

class HostFact
  # Class Variables
  @@certname = Puppet[:certname].downcase.split('.')
  @@hostname = @@certname[0]


  def self.hostname
    @@hostname
  end

  def self.naming_standard
    val = case @@hostname
      when /^(\w{1,5}\d?-|^)(\w{2,})(\d{1,2})-(\d{1,2})$/  then 'env_role_site_num'
      else 'Unknown_naming_standard'
    end
  end

  def self.arrHost
    case self.naming_standard
      when /nonprod/                  then @@hostname.split(/^(?:vircs-|cs-)([a-z][a-z0-9])([a-z]+)([0-9]{2})$/)
      when /env_role_site_num/        then @@hostname.split(/^(\w{1,5}\d?-|^)(\w{2,})(\d{1,2})-(\d{1,2})$/)
      else 'Error_Parsing_Hostname'
    end
  end
  
end


#######################################################
# env_role_site_num -  hostname with <env>[<num>]-<name>1-1  #
#######################################################

if HostFact.naming_standard == "env_role_site_num"

  Facter.add('host') do
    setcode do

      host   = {}
      _env   = HostFact.arrHost[1] #eg dev2-
      _name  = HostFact.arrHost[2] #eg somewebserver
      _site_num = HostFact.arrHost[3] #eg 1
      _node_num = HostFact.arrHost[4] #eg 2


      #Naming Standard
      host['naming_standard'] = HostFact.naming_standard

      #Domain
      case _env + _name

        when /puppet/         then host['domain'] = '<REDACTED>'

        # Generic default entries
        when /^dev-/          then host['domain'] = 'dev'
        when /^(dev\d|d\d)-/  then host['domain'] = _env.gsub(/(dev|d)(\d)-/, 'dev\2')
        when /^test-/         then host['domain'] = 'test'
        when /^(test\d|t\d)-/ then host['domain'] = _env.gsub(/(test|t)(\d)-/, 'test\2')
        when /^(uat|u-)/      then host['domain'] = '<REDACTED>'
        when /^(prod-|p-)/ then host['domain'] ='<REDACTED>'

        else host['domain'] ='unknown_domain:'
      end


      #Environment
      host['environment_raw'] = _env.tr('-', '')
      case _env + _name

        # Generic default entries
        when /^(d\d?-|dev)/  then host['environment'] = 'Dev'
        when /^(t\d?-|test)/ then host['environment'] = 'Test'
        when /^(u-|uat)/  then host['environment'] = 'UAT'
        when /^(prod|p-)/ then host['environment'] = 'Production'

        else host['environment'] = 'other'
      end


      #Tier
      case _name
        when /web/ then host['tier'] = 'Web'
        when /app/ then host['tier'] = 'App'
        when /db/  then host['tier'] = 'Database'
        when /b2b/          then host['tier'] = 'DMZ'
        else host['tier'] = 'unknown_tier'
      end




      #Application
      case _name
        when /AppA(web|app|db)/ then host['application'] = '<REDACTED>'

        else host['application'] = 'other'
      end


      #Role
      case _name
        when /puppet/ then host['role'] = 'Puppet'
        when /nagios/ then host['role'] = 'Nagios'
        when /syslog/ then host['role'] = 'Syslog'
        else host['role'] = 'unknown_role'

      end

      #Site
      case _site_num
          when /1/ then host['site'] = '<REDACTED>'
          when /2/ then host['site'] = '<REDACTED>'
          else host['site'] = 'env_role_site_num_unknown_site'
      end

      host['site_number'] = _site_num


      #Node Number
      host['node_number'] = _node_num


      host
    end
  end
end




# catch-all defaults

Facter.add('host') do
    setcode do
      {
        'naming_standard' => 'unconfigured',
        'domain' => 'unconfigured',
        'environment' => 'unconfigured',
        'role' => 'unconfigured',
        'tier' => 'unconfigured',
        'site' => 'unconfigured',
        'site_number' => 'unconfigured',
        'node_number' => 'unconfigured',
      }

  end
end

