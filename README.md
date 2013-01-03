Puppet_Module Package Provider
=============


Overview
---------

This module provides a `puppet_module` provider for the package type in Puppet. It allows you to manage
modules from the Puppet Forge as resources within Puppet's DSL.

This provider is a prototype and should be used with caution in non-production deployments.

The code behind version 0.0.1 is the work of [Pieter van de Bruggen](https://github.com/pvande). Thanks Pieter!


Installation & Usage
------------

The simplest way to get started is to install this module with the Puppet Module Tool, available in Puppet 2.7.14+

    puppet module install rcoleman/puppet_module
    
Then, in your puppet manifests, simply specify the `provider` property in your `package` type with the value of `puppet_module`. The resource title should be the fully name-spaced module name from the Puppet Forge. ex. `author/module`

Full example:

	package { 'author/mymodule':
	  ensure   => present,
	  provider => 'puppet_module',
	}


More Examples
-------

Ensure a module is present from the Puppet Forge
    
    package { 'puppetlabs/stdlib':
      ensure   => installed,
      provider => 'puppet_module',
    }

Ensure a module is absent


    package { 'puppetlabs/stdlib':
      ensure   => absent,
      provider => 'puppet_module',
    }


Requirements
------------

In addition to this module, you will need a version of Puppet that contains the Puppet Module Face, the library
that this module uses for its work. The Puppet Module Face comes with Puppet versions 2.7.14 and later (PE 2.5+).


Limitations
-----------

Many!

Because resource type

For example, this is merely a provider for the package type which sets its own properties. Therefore there's no way to specify the modulepath you want your module installed into, in this particular implementation.

Please Contribute!
------------------

This work is obviously a prototype and may behave completely differently by its 1.0.0 release. It needs a lot of work, so please contribute! Here are a few particular items that are missing from this provider.

* RSpec Tests
* Proper Pre-fetching

If you're interested in any other contributions, please file an issue, create your work in a feature branch and submit a pull request against this repo. For more information, see the CONTRIBUTING.md