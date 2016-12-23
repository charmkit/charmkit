require 'charmkit'

class Install < Charmkit::Hook
  use :nginx
  use :php

  def summon
    Php.add_host server_name: "php.example.com"
    Nginx.add_host server_name: "www.example.come"
  end

  def test
    is_installed? 'nginx-full'
    is_installed? 'php-fpm'
  end

end
