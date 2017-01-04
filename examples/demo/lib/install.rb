require 'charmkit'

class Install < Charmkit::Hook
  use :nginx
  use :php, alias: "pachep"


  nginx.add_host server: "bong.com"
  pachep.setup_php hai: "stfu"
end
