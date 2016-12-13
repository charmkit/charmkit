class Charmkit
  module Plugins
    module PHP
      module InstanceMethods
        def initialize
          if !is_installed? 'php-fpm'
            status :maintenance, 'Installing PHP'
            package [
              'php-fpm',
              'php-cgi',
              'php-curl',
              'php-gd',
              'php-json',
              'php-mcrypt',
              'php-readline',
              'php-mbstring',
              'php-xml'
            ]
            status :active, 'PHP installed.'
          end
        end
      end
    end
    register_plugin(:php, PHP)
  end
end
