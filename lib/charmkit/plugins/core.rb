class Charmkit
  module Plugins
    module Core
      # def self.load_dependencies(ck, *)
      #   ck.plugin :hookenv
      # end
      module ClassMethods
        include Charmkit::Helpers
      end
    end
    register_plugin(:core, Core)
  end
end
