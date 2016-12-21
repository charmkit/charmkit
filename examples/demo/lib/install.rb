require 'charmkit'

class Install < Charmkit
  plugin :core
  plugin :nginx
  plugin :vim

  vim :install do
    puts "i did it!"
  end

end
