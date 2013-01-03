require 'puppet/provider/package'
require 'puppet/face'
require 'uri'

Puppet::Type.type(:package).provide :puppet_module, :parent => Puppet::Provider::Package do
  desc "A Package provider for Puppet Modules"

  has_feature :versionable

  @@module = Puppet::Face[:module, :current]

  def self.installed
    @@module.list.map do |module_path, modules|
      modules.map do |mod|
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

  def install
    return self.update unless query.nil?
    options = {}
    options[:version] = resource[:ensure] unless resource[:ensure].is_a? Symbol
    
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

  def query
    self.class.installed.find { |x| x[:name] == resource[:name] }
  end

  def uninstall
    begin
      output = @@module.uninstall(resource[:name])
      raise output[:error][:oneline] if output.key?(:error)
    rescue => e
      self.fail "Could not uninstall: #{e.message}"
    end
  end

  def update
    return self.install if query.nil?
    options = {}
    options[:version] = resource[:ensure] unless resource[:ensure].is_a? Symbol
    
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