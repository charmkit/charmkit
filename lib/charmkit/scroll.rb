require "charmkit/helpers/template"
require "charmkit/helpers/runner"

class Scroll
  def self.inherited base
    base.send :include, InstanceMethods
    base.extend ClassMethods
    base.extend Charmkit::Helpers
  end
  module ClassMethods
    attr_accessor :summary, :desc
    attr_writer :dependencies

    def incant(state, &block)
      block.call if block_given?
    end

    def summary(text)
      @summary = text
    end

    def desc(text)
      @desc = text
    end

    def depends_on(dep)
      if @dependencies.nil?
        @dependencies = []
      end
      @dependencies << dep
    end
  end
  module InstanceMethods
    def to_hash
      {
        "summary" => self.class.instance_variable_get(:@summary),
        "desc" => self.class.instance_variable_get(:@desc),
        "dependencies" => self.class.instance_variable_get(:@dependencies)
      }
    end
  end
end