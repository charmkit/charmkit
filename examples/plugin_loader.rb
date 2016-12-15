require 'charmkit'

class PluginLoader
  include Charmkit::Plugin
  run 'ls -l /tmp'
end

