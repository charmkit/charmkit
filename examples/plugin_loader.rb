require 'charmkit'

class Install < Charmkit
  plugin :nginx
  install_vhost
end
