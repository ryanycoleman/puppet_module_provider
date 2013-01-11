Puppet::Type.newtype(:module) do

	ensurable do

	  newvalue(:present, :event => :module_installed) do
	    provider.create
	  end

	  newvalue(:absent, :event => :module_removed) do
	    provider.destroy
	  end

	  newvalue(:latest ) do
	  	provider.update
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