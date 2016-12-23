require 'charmkit'

class Install < Charmkit::Hook
  use :nginx

  def summon
    Nginx.add_host "www.example.com", :php
  end
end
