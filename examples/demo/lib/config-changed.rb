require 'charmkit'

class ConfigChanged < Charmkit
  use :nginx

  def summon
    Nginx.add_host server_name: "config-changed"
  end

end
