require 'tty-command'

class Charmkit
  module Helpers
    def cmd
      return TTY::Command.new
    end
  end
end
