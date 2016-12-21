require 'pathname'

class Charmkit
  module Helpers
    # sugar over pathname
    def path(pn)
      Pathname.new(pn)
    end

    # Create a file with data
    #
    # @param dst String
    # @param content String
    # @return nil
    #
    # @example
    #    file "/etc/nginx/nginx.conf", "Some data"
    def file(dst, content)
      File.write(dst, content)
    end

    def cat(src)
      return File.read(src)
    end

    # Installs packages
    #
    # @param packages Array
    # @param opts Hash
    # @return Boolean
    #
    # @example
    #   package ['nginx-full'], :update_cache
    def package(packages, *opts)
      if opts.include?(:update_cache)
        cmd.run "apt-get update"
      end
      cmd.run "apt-get install -qyf #{packages.join(' ')}"
    end

    # Checks if a package is installed
    #
    # @param package String
    # @return Boolean
    #
    # @example
    #   is_install? "nginx-full"
    def is_installed?(package)
      begin
        cmd.run "dpkg -s #{package}" and return true
      rescue
        return false
      end
    end
  end
end
