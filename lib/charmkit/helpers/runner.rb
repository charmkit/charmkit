require 'tty-command'

module Charmkit
  module Helpers
    extend Forwardable
    def_delegators :cmd, :run, :run!, :test

    def cmd
      if ENV['DRYRUN']
        TTY::Command.new(dryrun: true)
      else
        TTY::Command.new
      end
    end
  end
end
