require 'charmkit'

class Nginx < Scroll
  summary "NGINX incantation"
  desc "Installs nginx-full and provides helper methods for adding vhosts"

  depends_on "nginx-full"

  incant :nginx_install, :nginx_installed do
    puts "installing nginx"
  end
end
