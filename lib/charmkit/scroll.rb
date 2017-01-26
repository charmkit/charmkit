module Charmkit
  class Scroll
    include Helpers

    class << self
      # Apt packages that the scroll requires
      #
      # @param [String] pkg Name of apt package
      def depends_on(pkg)
        Dependencies << pkg
      end

    end
  end
end
