require 'charmkit'
require_relative 'nginx_scroll'

class Dokuwiki < Charmkit::Scroll
  react.trigger :nginx_install
  puts react.state

  react.on :nginx_available do
    puts "Ok nginx is installed, now installing dokuwiki"
  end
end
