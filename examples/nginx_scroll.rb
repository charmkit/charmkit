require 'charmkit'

class Nginx < Scroll
  summary "Nginx incantation"
  desc "Installs nginx-full and provides helper methods for adding vhosts"

  # Setup reactive states, in the form of
  # TRIGGER, TRANSITION FROM STATE => COMPLETED STATE
  react.when :nginx_install, :new => :nginx_installed

  react.only_once :nginx_installed do
    depends_on "nginx-full"
    puts "Nginx is installing, should only react once"
  end
end
