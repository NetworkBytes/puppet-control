## Puppet Control repository 

[![Build Status](https://img.shields.io/travis/NetworkBytes/puppet-control.svg)](https://travis-ci.org/NetworkBytes/puppet-control)




the branches represent the actual puppet environments by the use
of [R10K](https://github.com/puppetlabs/r10k)

R10K pulls together all the dependencies for an environment by reading in the Puppetfile 


### Usage

to deploy a specific environment use the command:

	/opt/puppet/bin/r10k deploy environment testing -v -t -p



#### Common Commands
Deploy all environments and Puppetfile specified modules

	r10k deploy environment -p

Deploy all environments but don't update/install modules

	r10k deploy environment

Deploy a specific environment, and its Puppetfile specified modules

	r10k deploy environment your_env -p

Deploy a specific environment, but not its modules

	r10k deploy environment your_env

Display all environments being managed by r10k

	r10k deploy display

Display all environments being managed by r10k, and their modules.

	r10k deploy display -p




## Puppetfile


Puppetfiles are a simple Ruby based DSL that specifies a list of modules to
install, what version to install, and where to fetch them from. 

Unlike librarian-puppet, the r10k implementation of Puppetfiles does not include
dependency resolution, but it is on the roadmap.

Because the Puppetfile format is actually implemented using a Ruby DSL any valid
Ruby expression can be used. That being said, being a bit too creative in the
DSL can lead to surprising (read: bad) things happening, so consider keeping it
simple.


#### Examples

    # Install puppetlabs/apache and keep it up to date with 'master'
    mod 'apache',
      :git => 'https://github.com/puppetlabs/puppetlabs-apache'

    # Install puppetlabs/apache and track the 'docs_experiment' branch
    mod 'apache',
      :git => 'https://github.com/puppetlabs/puppetlabs-apache',
      :ref => 'docs_experiment'

    # Install puppetlabs/apache and pin to the '0.9.0' tag
    mod 'apache',
      :git => 'https://github.com/puppetlabs/puppetlabs-apache',
      :tag => '0.9.0'

    # Install puppetlabs/apache and pin to the '83401079' commit
    mod 'apache',
      :git    => 'https://github.com/puppetlabs/puppetlabs-apache',
      :commit => '83401079053dca11d61945bd9beef9ecf7576cbf'

    # Install puppetlabs/apache and track the 'docs_experiment' branch
    mod 'apache',
      :git    => 'https://github.com/puppetlabs/puppetlabs-apache',
      :branch => 'docs_experiment'

### Forge

Modules can be installed using the Puppet module tool.

If no version is specified the latest version available at the time will be
installed, and will be kept at that version.

    mod 'puppetlabs/apache'

If a version is specified then that version will be installed.

    mod 'puppetlabs/apache', '0.10.0'

If the version is set to :latest then the module will be always updated to the
latest version available.

    mod 'puppetlabs/apache', :latest

### SVN

Modules can be installed via SVN. If no version is given, the module will track
the latest version available in the main SVN repository.

    mod 'apache',
      :svn => 'https://github.com/puppetlabs/puppetlabs-apache/trunk'

If an SVN revision number is specified with `:rev` (or `:revision`), that
SVN revision will be kept checked out.

    mod 'apache',
      :svn => 'https://github.com/puppetlabs/puppetlabs-apache/trunk',
      :rev => '154'

    mod 'apache',
      :svn      => 'https://github.com/puppetlabs/puppetlabs-apache/trunk',
      :revision => '154'

If the SVN repository requires credentials, you can supply the `:username` and
`:password` options.

    mod 'apache',
      :svn      => 'https://github.com/puppetlabs/puppetlabs-apache/trunk',
      :username => 'azurediamond',
      :password => 'hunter2'

**Note**: SVN credentials are passed as command line options, so the SVN
credentials may be visible in the process table when r10k is running. If you
choose to supply SVN credentials make sure that the system running r10k is
appropriately secured.

## Environment variables

It is possible to set an alternate name/location for your `Puppetfile` and
`modules` directory. This is useful if you want to control multiple environments
and have a single location for your `Puppetfile`.

Example:

    PUPPETFILE=/etc/r10k.d/Puppetfile.production \
    PUPPETFILE_DIR=/etc/puppet/modules/production \
    /usr/bin/r10k puppetfile install

NOTE: using these environment variables is not a suggested configuration, and
have different semantics than librarian-puppet. Specifically, the PUPPETFILE_DIR
is the environment that r10k will install modules into, and it will take full
control over that directory and _remove any unmanaged content_. Use these
variables with caution.

