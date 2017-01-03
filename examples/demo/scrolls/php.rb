require 'charmkit'

class Php < Charmkit::Scroll
  depends_on "php-cgi"

  def setup_php(options = {})
    puts "setting up php #{options}"
  end
end
