# 
# Extract all environment variables and create facts
#
ENV.each do |key,val|
  Facter.add("env_#{key.downcase}".to_sym) do
    setcode do
      val
    end
  end
end
