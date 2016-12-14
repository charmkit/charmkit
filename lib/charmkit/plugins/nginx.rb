class Charmkit
  module Plugins
    module Nginx
      module ClassMethods
        def install_vhost
          puts "installing vhost"
        end
        def nginx
          if !is_installed? 'nginx-full'
            status :maintenance, 'Installing NGINX'
            package ['nginx-full']
            status :active, "NGINX installed."
          end
        end
      end
    end
    register_plugin(:nginx, Nginx)
  end
end
