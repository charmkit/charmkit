require "tty-command"

module Charmkit
  # Runner commands exposed to top level Object
  #
  # eg:
  # require 'charmkit'
  # run 'ls -l'
  module Runner
    def run(data)
      if ENV['DRYRUN']
        puts "DRYRUN: #{data}"
      else
        cmd = TTY::Command.new(printer: :null)
        return cmd.run(data)
      end
    end

    # calls status-set in juju environment
    def status(level="maintenance", msg="")
      level = level.to_sym if level.is_a? String
      run "status-set #{level.to_s} #{msg}"
    end

    # installs apt packages
    def pkg(packages, *opts)
      if opts.include?(:update_cache)
        run "apt-get update"
      end
      run "apt-get install -qyf #{packages.join(' ')}"
    end
  end
end
