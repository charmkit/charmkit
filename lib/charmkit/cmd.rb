require 'thor'

module Charmkit
  class Cmd < Thor
    desc "hook NAME", "Processes hook"
    def hook(name)
      puts "Running hook: #{name}"
    end
  end
end
