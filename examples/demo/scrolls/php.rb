require 'scroll'

class Php < Scroll
  depends_on "php-cgi"

  def add_host(options = {})
    puts "Adding #{options[:server_name]} for the php portion"
  end
end
