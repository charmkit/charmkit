require 'charmkit'

class Install < Charmkit::Hook
  use :nginx
  use :php

  nginx.add_host server: "bong.com"
  php.setup_php hai: "stfu"
  run! 'ls -l /tmp'
end
