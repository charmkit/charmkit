require "charmkit/version"
require "tty-command"

module Charmkit
  def run(data)
    cmd = TTY::Command.new
    return cmd.run(data)
  end
end
