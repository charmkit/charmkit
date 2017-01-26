module Charmkit
  module Base
    include Dependencies
    include Helpers

    # Include scrolls to be used within hook execution
    #
    # Note: Idea lifted from https://github.com/mckomo/metaxa
    # @param [Symbol] name symbol of scroll
    # @param [Hash] options (NotImplemented) Options to be passed to scroll
    # @example
    #   use :nginx
    #   nginx.add_host server: "test.com"
    def use(name, options = {})
      require "charmkit/scrolls/#{name.to_s}"
      # require "./scrolls/#{name.to_s}"
      name_ref = name
      if options[:alias]
        name_ref = options[:alias]
      end

      var_module = Module.new do
        attr_accessor name_ref.to_sym
      end
      extend var_module
      set(name_ref, to_const(name.to_s).new)
    end

    private
    def get(variable)
      instance_variable_get("@#{variable}")
    end

    def set(variable, value)
      instance_variable_set("@#{variable}", value)
    end

    def to_const(name)
      klass = name.classify
      klass.constantize
    end
  end
end
