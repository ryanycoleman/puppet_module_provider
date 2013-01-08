Puppet_Module Type and Provider
=============


Overview
---------

This module provides a module type and a forge provider for managing Puppet modules from the Forge as resources in the DSL.

This work is a prototype and should be used with caution in non-production deployments.

The code behind version 0.0.1 is the work of [Pieter van de Bruggen](https://github.com/pvande). Thanks Pieter!


Installation & Usage
------------

The simplest way to get started is to install this module with the Puppet Module Tool, available in Puppet 2.7.14+

    puppet module install rcoleman/puppet_module
    
Then, in your puppet manifests, build module resources to suit.
The resource title should be the fully name-spaced module name from the Puppet Forge. ex. `author/module`
By default, modules are installed into the first modulepath configured in puppet.conf (or default settings)

Simple example:

	module { 'author/mymodule':
	  ensure   => present,
	}


More Examples
-------

Ensure a module is present from the Puppet Forge
    
  module { 'puppetlabs/stdlib':
    ensure   => installed,
  }

Ensure a module is absent


  module { 'puppetlabs/stdlib':
    ensure   => absent,
  }

Install a particular version of a module from the Puppet Forge

  module { 'puppetlabs/stdlib':
    ensure => '2.6.0',
  }

Install a module into a particular directory or 'module path'

  module { 'puppetlabs/stdlib':
    ensure     => present,
    modulepath => '/etc/puppet/modules',
  }


Requirements
------------

In addition to this module, you will need a version of Puppet that contains the Puppet Module Face, the library
that this module uses for its work. The Puppet Module Face comes with Puppet versions 2.7.14 and later (PE 2.5+).


Limitations
-----------

### What works?

- Install a module
- Uninstall a module
- Upgrade a module to a specific version
  - The above three with a user-supplied modulepath

### What doesn't work?

- Using a user-supplied modulepath for determining the existance of a module (exists? method)
- Some operations involving specific module versions, especially when dealing with dependencies are wonky
- Anything to do with environments (though the face is broken in this regard too)
- No puppet resource inspection (self.instances)
- Upgrade a module to 'latest'
- Lots of other things that I haven't found yet


Please Contribute!
------------------

This work is obviously a prototype and may behave completely differently by its 1.0.0 release. It needs a lot of work, so please contribute! Here are a few particular items that are missing from this provider.

* RSpec Tests
* Proper Pre-fetching
* Bug Fixes
* Features!

If you're interested in any other contributions, please file an issue, create your work in a feature branch and submit a pull request against this repo. For more information, see the CONTRIBUTING.md