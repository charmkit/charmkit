module Charmkit
  class Scroll
    class << self
      include Helpers
    end
    module ScrollBase
      # Apt packages that the scroll requires
      #
      # @param [String] pkg Name of apt package
      def depends_on(pkg)
        Dependencies << pkg
      end

    end
    extend ScrollBase
  end
end
