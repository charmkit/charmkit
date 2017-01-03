require 'charmkit'

class Nginx < Charmkit::Scroll
  def prereq
    depends_on "nginx-full"
  end

  def add_host(options = {})
    puts "Adding #{options}"
  end
end
