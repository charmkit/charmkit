require 'charmkit/helpers'

module Charmkit
  module Plugin
    # ClassMethods module exposes all necessary methods that a plugin author
    # will need for creating plugins.
    module ClassMethods
      include Helpers

      # The name of the plugin
      # @return [String, nil] Name of plugin
      attr_reader :plugin_name

      # Deb package dependencies
      # @return [Array<Package>] A list of package depdencies for plugin
      attr_reader :dependencies


      # @api private
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

    def self.included(by)
      by.extend ClassMethods
    end
  end
end
