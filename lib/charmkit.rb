require 'helpers'
require 'dependencies'

class Charmkit

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

  class << self
    include Helpers

    # Include scrolls to be used within hook execution
    #
    # @param [Symbol] name symbol of scroll
    # @param [Hash] options (NotImplemented) Options to be passed to scroll
    def use(name, options = {})
      require "./scrolls/#{name.to_s}"
      name = name.to_s.classify
      const_set(name, name.constantize.new)
    end
  end
end
