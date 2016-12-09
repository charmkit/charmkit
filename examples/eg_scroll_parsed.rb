require 'charmkit'

class Nginx < Scroll
  summary "Nginx incantation"
  desc "Installs nginx-full and provides helper methods for adding vhosts"

  depends_on "nginx-full"

  puts "Current state: #{react.state}"
  react.when :nginx_install, :new => :nginx_installed

  react.on :nginx_install do
    puts "nginx is installed"
  end

  react.trigger :nginx_install

end
