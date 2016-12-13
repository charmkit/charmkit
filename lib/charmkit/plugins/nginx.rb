class Charmkit
  module Plugins
    module Nginx
      module InstanceMethods
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
    register_plugin(:nginx, Nginx)
  end
end
