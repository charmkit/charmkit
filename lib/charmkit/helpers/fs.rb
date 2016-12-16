require 'fileutils'
require 'pathname'

module Charmkit
  module Helpers

    FileUtils.singleton_methods.each do |m|
      define_method m, FileUtils.method(m).to_proc
    end

    # Sugar over pathname
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

    # Check if file exists
    #
    # @param path String
    # @return Boolean
    #
    # @example
    #    is_file? "/etc/nginx/nginx.conf"
    def is_file?(path)
      return File.exists? path
    end

    def is_dir?(path)
      return Dir.exists? path
    end

    def cat(src)
      return File.read(src).chomp
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
        run "apt-get update"
      end
      run "apt-get install -qyf #{packages.join(' ')}"
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
        run "dpkg -s #{package}" and return true
      rescue
        return false
      end
    end
  end
end
