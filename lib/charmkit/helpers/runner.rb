require 'tty-command'

module Charmkit
  module Helpers
    # Run commands optionally getting it's output, error
    #
    # run 'ls -l /tmp'
    def run(data)
      if ENV['DRYRUN']
        cmd = TTY::Command.new(dry_run: true)
        return cmd.run(data)
      else
        cmd = TTY::Command.new
        return cmd.run(data)
      end
    end
  end
end
