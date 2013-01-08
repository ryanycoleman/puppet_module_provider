Puppet::Type.newtype(:module) do

	ensurable do

	  attr_accessor :latest

	  newvalue(:present, :event => :module_installed) do
	    provider.create
	  end

	  newvalue(:absent, :event => :module_removed) do
	    provider.destroy
	  end

    newvalue(/./) do
    	provider.create
  	end

  	defaultto :present
	end


	newparam(:name, :namevar => true)

	newparam(:version)

	newparam(:modulepath)

	newparam(:source)

end