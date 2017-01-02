require 'charmkit/dependencies'

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
        require "charmkit/scrolls/#{name.to_s}"
        name_ref = name
        if options[:alias]
          name_ref = options[:alias]
        end
        const_set(name_ref, to_const(name).new)
      end

      private
      def to_const(name)
        klass = name.classify
        klass.constantize
      end
    end
  end
end
