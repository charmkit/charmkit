require 'helpers'
require 'dependencies'

class Charmkit

  # Handles installation of any apt packages in the Dependencies class
  def install
    Dependencies.install
  end

  # Summon main hook tasks
  def summon
    raise "Called from #{self.class.name} but did not override the summon method"
  end

  class << self
    include Helpers

    def use(name, options = {})
      require "./scrolls/#{name.to_s}"
      name = name.to_s.classify
      const_set(name, name.constantize.new)
    end

    def deps
      Dependencies
    end

  end
end
