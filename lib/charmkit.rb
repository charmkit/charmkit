require "charmkit/version"

class Charmkit
  # A generic exception by Charmkit
  class Error < StandardError; end

  @opts = {}

  module Plugins
    @plugins = {}

    def self.load_plugin(name)
      unless plugin = @plugins[name]
        require "charmkit/plugins/#{name}"
        raise Error, "plugin #{name} did not register itself correctly in Charmkit::Plugins" unless plugin = @plugins[name]
      end
      plugin
    end

    def self.register_plugin(name, mod)
      @plugins[name] = mod
    end

    module Base
      module ClassMethods
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
        def plugin(plugin, *args, &block)
          plugin = Plugins.load_plugin(plugin) if plugin.is_a?(Symbol)
          plugin.load_dependencies(self, *args, &block) if plugin.respond_to?(:load_dependencies)
          self.include(plugin::InstanceMethods) if defined?(plugin::InstanceMethods)
          self.extend(plugin::ClassMethods) if defined?(plugin::ClassMethods)
          plugin.configure(self, *args, &block) if plugin.respond_to?(:configure)
          nil
        end

      end
      module InstanceMethods
        # The class-level options hash. This should probably not be modified at
        # the instance level.
        def opts
          self.class.opts
        end

        # This performs the actual work of installing, configuring, restarting
        # of services.
        #
        #    class Install < Charmkit
        #      def summon
        #        cp "#{ENV['JUJU_CHARM_DIR']}/templates/nginx.conf.tpl",
        #           "/etc/nginx/nginx.conf"
        #      end
        #    end
        def summon
        end
      end
    end
  end

  extend Plugins::Base::ClassMethods
  plugin Plugins::Base
end
