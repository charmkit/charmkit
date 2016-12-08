require 'charmkit'

class Nginx < Scroll
  summary "Nginx incantation"
  desc "Installs nginx-full and provides helper methods for adding vhosts"

  depends_on "nginx-full"

  #  state "nginx.available"
  def summon
    puts "ive been summoned"
  end
end

m = Nginx.new
m.summon
