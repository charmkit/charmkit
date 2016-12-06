require 'tty-command'

module Charmkit
  module Helpers
    def cmd
      return TTY::Command.new
    end
  end
end
