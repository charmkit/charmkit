require 'charmkit'

class Install < Charmkit
  scroll :core
  scroll :vim

  vim :install do
    puts "i did it!"
  end

end
