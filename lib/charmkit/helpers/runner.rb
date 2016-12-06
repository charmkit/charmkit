require 'tty-command'

module Charmkit
  module Helpers
    def run(*cmd)
      runner = TTY::Command.new
      return runner.run(*cmd)
    end
  end
end
