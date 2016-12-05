require 'erb'

module Charmkit
  module Helpers
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
  end
end
