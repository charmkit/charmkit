require "charmkit/version"
require "charmkit/helpers"

class Charmkit

  # A generic exception by Charmkit
  class Error < StandardError; end

  @opts = {}

  module Scrolls

    @scrolls = {}

    def self.load_scroll(name)
      unless scroll = @scrolls[name]
        require "charmkit/scrolls/#{name}"
        raise Error, "scroll #{name} did not register itself correctly in Charmkit::Scrolls" unless scroll = @scrolls[name]
      end
      scroll
    end

    def self.register_scroll(name, mod)
      @scrolls[name] = mod
    end

    module Base

      module ClassMethods
        include Charmkit::Helpers

        # Generic options for this class, plugins store their options here.
        attr_reader :opts

        def inherited(subclass)
          subclass.instance_variable_set(:@opts, opts.dup)
          subclass.opts.each do |key, value|
            if value.is_a?(Enumerable) && !value.frozen?
              subclass.opts[key] = value.dup
            end
          end
          # ENV.each do |k, v|
          #   subclass.instance_variable_set("@#{k.downcase}", v) if k.include? "JUJU"
          # end


        end
        def scroll(scroll, *args, &block)
          scroll = Scrolls.load_scroll(scroll) if scroll.is_a?(Symbol)
          scroll.load_dependencies(self, *args, &block) if scroll.respond_to?(:load_dependencies)
          self.include(scroll::InstanceMethods) if defined?(scroll::InstanceMethods)
          self.extend(scroll::ClassMethods) if defined?(scroll::ClassMethods)
          scroll.configure(self, *args, &block) if scroll.respond_to?(:configure)
          nil
        end

      end
      module InstanceMethods
        include Charmkit::Helpers
        # The class-level options hash. This should probably not be modified at
        # the instance level.
        def opts
          self.class.opts
        end
      end
    end
  end

  extend Scrolls::Base::ClassMethods
  scroll Scrolls::Base
end
