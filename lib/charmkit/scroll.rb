module Charmkit
  class Scroll
    class << self
      include Helpers
      # Apt packages that the scroll requires
      #
      # @param [String] pkg Name of apt package
      def depends_on(pkg)
        Dependencies << pkg
      end

    end
  end
end
