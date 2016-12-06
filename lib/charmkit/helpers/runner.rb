require 'open3'

module Charmkit
  module Helpers
    def run(*cmd)
      stdout_s, stderr_s, status = Open3.capture3(*cmd)
      if not status.success?
        raise StandardError, "Failed to run command: #{stderr_s}"
      end
      return {
        :out => stdout_s,
        :err => stderr_s,
        :status => status
      }
    end
  end
end
