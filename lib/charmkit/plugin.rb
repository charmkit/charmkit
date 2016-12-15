require 'charmkit/helpers'

module Charmkit
  class Plugin
    module Base
      include Helpers

      attr_reader :dependencies

      def self.extended(by)
        by.instance_exec do
          @dependencies = []
        end
      end

      # Deb package list that plugin requires
      #
      # @attr [String] name The name of deb package
      # @attr [Symbol] state The state of package once installed
      Package = Struct.new(:name,
                           :state)

      def depends_on(pkg, options = {})
        options = {
          :state => :installed
        }.merge(options)
        package = Package.new(pkg, *options.values_at(:state))
        @dependencies << package
        package
      end

      # Defines states that the plugin will react to
      # @param [Symbol] state A state that the plugin to should react to
      #
      # @return [Array<States>]
      # @example
      #   react_to :nginx_available, :install_app

      def react_to(state)
        puts "reacting to #{state}"
      end
    end

    def self.inherited(by)
      by.extend Base
    end
    include Base
  end
end
