require 'fileutils'
require 'tty-command'
require 'erb'

class Charmkit
  module Helpers
    module FS
      FileUtils.singleton_methods.each do |m|
        define_method m, FileUtils.method(m).to_proc
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
        return File.read(src)
      end

      # Run commands optionally getting it's output, error
      #
      # run 'ls -l /tmp'
      def run(data)
        if ENV['DRYRUN']
          puts "DRYRUN: #{data}"
        else
          cmd = TTY::Command.new(printer: :null)
          return cmd.run(data)
        end
      end


      # Processes templates
      #
      # template 'my-template.erb' '/etc/config/me.conf', service_name: "nginx"
      class TemplateRenderer
        def self.empty_binding
          binding
        end

        def self.render(template_content, locals = {})
          b = empty_binding
          locals.each { |k, v| b.local_variable_set(k, v) }
          ERB.new(template_content).result(b)
        end
      end

      def template(src, dst, **context)
        rendered = TemplateRenderer.render(File.read(src), context)
        File.write(dst, rendered)
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

      # Hook Environment Commands #############################################
      # calls status-set in juju environment
      def status(level=:maintenance, msg="")
        levels = [:maintenance, :active, :blocked, :waiting]
        raise unless levels.include?(level)
        run "status-set #{level.to_s} '#{msg}'"
      end

      def config(item)
        out, err = run "config-get '#{item}'"
        return out.chomp
      end

      def resource(item)
        out, err = run "resource-get '#{item}'"
        return out.chomp
      end

      def unit(item)
        out, err = run "unit-get '#{item}'"
        return out.chomp
      end

      def action(item)
        out, err = run "action-get '#{item}'"
        return out.chomp
      end

      def action=(item)
        out, err = run "action-set '#{item}'"
        return out.chomp
      end

      def log(msg)
        run "juju-log #{msg}"
      end

    end
  end
end
