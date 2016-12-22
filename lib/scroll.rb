require "active_support/core_ext/string/inflections"
require 'charmkit/helpers'

class Scroll
  class << self
    include Charmkit::Helpers

    def initialize
      @dependencies = []
    end

    def use(name, options = {})
      require "./scrolls/#{name.to_s}"
      name = name.to_s.classify
      const_set(name, name.constantize.new)
    end

    def depends_on(pkg)
      @dependencies << pkg
    end

    def list_deps
      @dependencies
    end
  end
end
