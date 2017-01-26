module Charmkit
  class Scroll
    module ScrollBase
      include Helpers

      # Apt packages that the scroll requires
      #
      # @param [String] pkg Name of apt package
      def depends_on(pkg)
        Dependencies << pkg
      end

      # Install deps
      #
      def deps
        Dependencies
      end
    end
    extend ScrollBase
  end
end
