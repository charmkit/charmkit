require 'charmkit'

class Onoe < Charmkit
  plugin :core

  def test
    puts run 'ls -l /tmp'
  end
end

Onoe.new.test
