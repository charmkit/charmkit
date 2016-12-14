require 'charmkit/helpers'

module Charmkit
  module Plugin
    # ClassMethods module exposes all necessary methods that a plugin author
    # will need for creating plugins.
    module ClassMethods
      include Charmkit::Helpers

      attr_reader :plugin_name

      def react_on(state)
        puts "reacting to #{state}"
      end
    end

    def self.included(by)
      by.extend ClassMethods
    end
  end
end
