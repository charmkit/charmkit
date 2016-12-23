require 'charmkit/helpers'
require 'charmkit/dependencies'
require 'charmkit/scroll'
require 'charmkit/cli'

module Charmkit
  class Hook

    # Handles installation of any apt packages in the Dependencies class
    def deps
      Dependencies
    end

    # Summon main hook tasks
    def summon
      raise <<-EOF
Tried to call summon for #{self.class.name} but the summon method does not
exist in the Hook.
EOF
    end

    # Tests basic hooks like checking if a package got installed
    def test; end

    class << self
      include Helpers

      # Include scrolls to be used within hook execution
      #
      # @param [Symbol] name symbol of scroll
      # @param [Hash] options (NotImplemented) Options to be passed to scroll
      def use(name, options = {})
        require "./scrolls/#{name.to_s}"
        name = name.to_s.classify
        const_set(name, name.constantize.new)
      end
    end
  end
end
