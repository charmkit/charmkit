require "tty-command"

module Charmkit
  module Runner
    def self.run(data)
      cmd = TTY::Command.new(printer: :null)
      return cmd.run(data)
    end
  end
end
