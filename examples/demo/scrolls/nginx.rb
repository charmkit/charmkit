require 'scroll'

class Nginx < Scroll
  depends_on "nginx-full"

  def add_host(options = {})
    puts "Adding #{options[:server_name]}"
  end
end
