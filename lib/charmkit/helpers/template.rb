require 'erb'

module Charmkit
  module Helpers
    # Helper for rendering file and inline templates
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

    # Reads from a erb file and renders the content with context
    #
    # @param src String - file path of template
    # @param dst String - file path location to save
    # @param context Hash - parametized variables to pass to template
    # @return Boolean
    #
    # @example
    #     template('examples/my-demo-charm/templates/vhost.conf',
    #              '/tmp/nginx-data.conf',
    #              public_address: 'localhost',
    #              app_path: '/srv/app')
    def template(src, dst, **context)
      rendered = TemplateRenderer.render(File.read(src), context)
      File.write(dst, rendered)
    end

    # Reads from a embedded template in the rake task itself.
    #
    # @param src String - The data found after __END__
    # @param dst String - Save location
    # @param context Hash - variables to pass into template
    # @return Boolean
    #
    # @example
    #     inline_template('vhost.conf',
    #                     '/etc/nginx/sites-enabled/default')
    #                     server_name: "example.com")
    #
    #     __END__
    #     @@ vhost.conf
    #     server { name <%= server_name %> }
    def inline_template(name, dst, **context)
      templates = {}
      begin
        app, data = File.read(caller.first.split(":").first).split("__END__", 2)
      rescue Errno::ENOENT
        app, data = nil
      end

      data.strip!
      if data
        template = nil
        data.each_line do |line|
          if line =~ /^@@\s*(.*\S)\s*$/
            template = String.new
            templates[$1.to_s] = template
          elsif
            template << line
          end
        end

        begin
          rendered = TemplateRenderer.render(templates[name], context)
        rescue
          puts "Unable to load inline template #{name}"
          exit 1
        end
        File.write(dst, rendered)
      end
    end
  end
end
