require 'puppet/face'
require 'uri'

Puppet::Type.type(:module).provide :forge do
  desc "A Forge provider for Puppet Modules"

  @@module = Puppet::Face[:module, :current]

  def create
    return self.update unless exists?.nil?
    options = {}
    options[:version] = resource[:ensure] unless resource[:ensure].is_a? Symbol

    # Allow modulepath to be set
    options[:modulepath] = resource[:modulepath]
    
    if resource[:source] =~ /$https?:/
      options[:module_repository] = resource[:source]
    elsif resource[:source]
      resource[:name] = resource[:source]
    end
    
    begin
      output = @@module.install(resource[:name], options)
      raise output[:error][:oneline] if output.key?(:error)
    rescue => e
      self.fail "Could not install: #{e.message}"
    end
  end

  def latest
    @@module.search(resource[:name])[:answers][0]['version']
  end

  def exists?
    self.class.installed.find { |x| x[:name] == resource[:name] }
  end

  def self.installed
    @@module.list.map do |module_path, modules|

      modules.map do |mod|
        #puts mod.inspect
        {
          :name => mod.forge_name,
          :ensure => mod.version,
          :modulepath => module_path,
          :provider => :puppet_module,
        }
      end

    end.flatten
  end

  def self.instances
    installed.map { |x| new(x) }
  end


  def destroy
    begin
      output = @@module.uninstall(resource[:name])
      raise output[:error][:oneline] if output.key?(:error)
    rescue => e
      self.fail "Could not uninstall: #{e.message}"
    end
  end

  def update
    return self.create if exists?.nil?
    options = {}
    options[:version] = resource[:ensure] unless resource[:ensure].is_a? Symbol

    # Allow modulepath to be set
    options[:modulepath] = resource[:modulepath]
    
    if resource[:source] =~ /$https?:/
      options[:module_repository] = resource[:source]
    elsif resource[:source]
      resource[:name] = resource[:source]
    end
    
    begin
      output = @@module.upgrade(resource[:name], options)
      raise output[:error][:oneline] if output.key?(:error)
    rescue => e
      self.fail "Could not update: #{e.message}"
    end
  end
end