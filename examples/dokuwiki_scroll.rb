require 'charmkit'
require_relative 'nginx_scroll'

class Dokuwiki < Scroll
  depends_on "php"

  react.trigger :nginx_install
end

d = Dokuwiki.new
require 'pp'
pp d.to_hash
pp $0
