require "tty-command"

module Charmkit
  module DSL
    def run(data)
      if ENV['DRYRUN']
        puts "DRYRUN: #{data}"
      else
        cmd = TTY::Command.new(printer: :null)
        return cmd.run(data)
      end
    end
  end
end
