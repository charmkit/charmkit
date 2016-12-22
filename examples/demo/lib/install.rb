require 'charmkit'

class Install < Charmkit
  use :nginx
  use :php

  def summon
    Php.add_host server_name: "php.example.com"
    Nginx.add_host server_name: "www.example.come"
  end

end
