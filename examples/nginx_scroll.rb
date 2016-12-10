require 'charmkit'

# Nginx reactive layer
#
# Triggers:
#   * nginx_install - Will install nginx and its required packages
# States:
#   * nginx_installing
#   * nginx_available

class Nginx < Charmkit::Scroll
  summary "Nginx incantation"
  desc "Installs nginx-full and provides helper methods for adding vhosts"

  # Setup reactive states, in the form of
  # TRIGGER, TRANSITION FROM STATE => TO STATE
  react.when :nginx_install, :start => :nginx_installing
  react.when :nginx_installed, :nginx_installing => :nginx_available

  react.only_once :nginx_installing do
    depends_on "nginx-full"
    puts "Nginx is installed"
    react.trigger :nginx_installed
  end
end
