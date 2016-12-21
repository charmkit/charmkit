class Charmkit
  module Plugins
    module NGINXPlugin
      module InstanceMethods
        class Nginx
          def initialize
            yield(self)
          end
          def install_vhost
            puts "installing vhost"
          end
        end
      end
    end
    register_plugin(:nginx, NGINXPlugin)
  end
end
