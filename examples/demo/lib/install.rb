require 'charmkit'

class Install < Charmkit::Hook
  use :nginx

  def summon
    Nginx.add_host server: "www.example.com"
  end
end
