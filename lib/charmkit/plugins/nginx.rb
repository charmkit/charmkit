class Charmkit
  module Plugins
    module NGINXPlugin
      module InstanceMethods
        class NGINX
          include Charmkit::Plugins::Core::InstanceMethods
          def initialize
            if !is_installed? 'nginx-full'
              status :maintenance, 'Installing NGINX'
              package ['nginx-full']
              status :active, "NGINX installed."
            end
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
