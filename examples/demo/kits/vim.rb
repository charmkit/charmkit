class Charmkit
  module Plugins
    module VimPlugin
      module ClassMethods
        def vim(switch, &block)
          if switch == :install
            puts "install vim"
          end
          block.call if block_given?
        end
      end
    end
    register_plugin(:vim, VimPlugin)
  end
end
