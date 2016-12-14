require 'charmkit'

module Charmkit
  module Plugins
    class Nginx
      include Charmkit::Plugin

      depends_on 'nginx-full'


      private

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
end
