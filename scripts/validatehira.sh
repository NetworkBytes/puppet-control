
#!/bin/sh

# Search the module path for all key values used in a hiera_array lookup, and then perform the equivalent of a hiera_array() from puppet.

# Borrowed from https://ask.puppetlabs.com/question/10999/hiera-how-can-i-tell-which-class-triggered-expected-array-and-got-nilclass/?answer=11006#post-id-11006

# The original:
# ```
# for y in $(for x in $(puppet config print modulepath | sed -e "s/:/ /g"); do grep -PIRho "(?<=hiera_array\(['|\"|$])([^'|^\"|^,|^\)]+)" $x; done); do echo hiera  -d -a -c $(puppet config print confdir)/hiera.yaml $y <key=value pairs as needed for your hiera.yaml>; done
# ```
# "This is a (tested) nested for loop that will search your module path for all key values used in a hiera_array lookup, and then will perform the equivalent of a hiera_array() from puppet. You will likely need to set one or more key=value items to cover variables used in your hiera.yaml."

# Set your key=value pairs here
myKeyValue="osfamily=RedHat environment=develop"

########

confdir=$(puppet config print confdir)

# getSubclasses - spits out key::
### NOTE THIS MIGHT BE WRONG now that we switched from `<=hiera` to `<=hiera_array`
#[root@puppet3 ~]# getSubclasses 
#wordpress::wp_owner
#wordpress::install_dir
#wordpress::wp_owner
#wordpress::wp_group
#wordpress::db_user
#wordpress::db_password
getSubclasses () {
    modulepaths=$(puppet config print modulepath | sed -e "s/:/ /g")
    for modulepath in $modulepaths; do
        #grep -PIRho "(?<=hiera_array\(['|\"|$])([^'|^\"|^,|^\)]+)" $modulepath
        grep --perl-regexp --binary-files=without-match --recursive --no-filename --only-matching "(?<=hiera_array\(['|\"|$])([^'|^\"|^,|^\)]+)" $modulepath
    done
}

getSubclasses | while read subclass; do

    # echo hiera  -d -a -c $(puppet config print confdir)/hiera.yaml $y <key=value pairs as needed for your hiera.yaml>
    #echo $subclass
    echo hiera -d -a -c $confdir/hiera.yaml $subclass $myKeyValue
done
