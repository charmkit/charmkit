require 'charmkit'
require 'pp'

class Nginx < Scroll
  summary "NGINX incantation"
  desc "Installs nginx-full and provides helper methods for adding vhosts"

  depends_on "nginx-full"

  incant :nginx_install do
    cmd.run 'ls -l'
    puts "Running: #{@summary}"
  end
end

n = Nginx.new
puts n.to_hash
