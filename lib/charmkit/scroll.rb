require "charmkit/helpers/template"
require "charmkit/helpers/runner"
require "charmkit/helpers/fs"
require "charmkit/helpers/hookenv"
require "charmkit/reactive"

class Scroll

  def self.inherited base
    base.send :include, InstanceMethods
    base.extend ClassMethods
    base.extend Charmkit::Helpers

  end
  module ClassMethods
    @@react = Charmkit::Reactive.new

    def react
      @@react
    end

    def summary(text)
      @summary = text
    end

    def desc(text)
      @desc = text
    end

    def depends_on(*deps)
      run "apt-get -qq update"
      run "apt-get install -qyf deps"
    end
  end
  module InstanceMethods
    def to_hash
      {
        "name" => self.class.name.downcase,
        "summary" => self.class.instance_variable_get(:@summary),
        "desc" => self.class.instance_variable_get(:@desc),
        "dependencies" => self.class.instance_variable_get(:@dependencies)
      }
    end

    def summon
      raise NotImplementedError, "Summon must be overridden in (#{self.class.name}) class."
    end
  end
end
