class Charmkit
  module Scrolls
    module Core

      # def self.load_dependencies(ck, *)
      #   ck.scroll :hookenv
      # end
      module ClassMethods
        puts "core"
      end
    end
    register_scroll(:core, Core)
  end
end
