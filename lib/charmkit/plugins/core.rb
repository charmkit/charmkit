class Charmkit
  module Plugins
    module Core
      # def self.load_dependencies(ck, *)
      #   ck.plugin :hookenv
      # end
      module ClassMethods
        def hai
          puts "hi"
        end
      end
    end
    register_plugin(:core, Core)
  end
end
