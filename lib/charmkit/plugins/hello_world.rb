class Charmkit
  module Plugins
    # An example plugin
    module SayHello
      module ClassMethods
        def say_what_one_more_time
          puts "I DARE YOU, I DOUBLE DARE YOU"
        end
      end
    end
    register_plugin(:hello_world, SayHello)
  end
end
