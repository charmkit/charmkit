require 'fileutils'
require 'tty-command'
require 'erb'

class Charmkit
  module Plugins
    module Core
      def self.load_dependencies(ck, *)
        ck.plugin :hookenv
      end
      module InstanceMethods
        FileUtils.singleton_methods.each do |m|
          define_method m, FileUtils.method(m).to_proc
        end

        def file(dst, content:)
          File.write(dst, content)
        end

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
        # package ['nginx-full'], :update_cache
        def package(packages, *opts)
          if opts.include?(:update_cache)
            run "apt-get update"
          end
          run "apt-get install -qyf #{packages.join(' ')}"
        end

        def is_installed?(package)
          begin
            run "dpkg -s #{package}" and return true
          rescue
            return false
          end
        end
      end
    end
    register_plugin(:core, Core)
  end
end
