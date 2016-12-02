require 'charmkit'

class Install < Charmkit
  plugin :core

  def summon
    puts run 'ls -l /tmp'
  end
end
