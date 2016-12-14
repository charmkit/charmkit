class Charmkit
  module Plugins
    module PoopoooPlugin
      module ClassMethods
      def poo
        puts "poo"
      end
      end
    end
    register_plugin(:poo, PoopoooPlugin)
  end
end
