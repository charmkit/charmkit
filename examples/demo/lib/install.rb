require 'scroll'

class Install < Scroll
  use :nginx
  use :php

  Php.add_host server_name: "php.example.com"
  Nginx.add_host server_name: "www.example.come"


  puts list_deps
end
