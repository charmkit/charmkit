require 'charmkit/helpers'

class Scroll
  extend Enumerable

  class << self
    include Charmkit::Helpers

    def install(&block)
      puts "install method"
      run 'ls -l /tmp'
      block.call if block_given?
    end
  end
end
