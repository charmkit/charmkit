module Charmkit
  module Helpers
    module Crypt
      # Generate a password salt
      #
      # @param [Integer] min mininum number of characters
      # @param [Integer] max maximum number of characters
      def gen_salt(min=0, max=20)
        (min...max).map { ('a'..'z').to_a[rand(26)] }.join
      end
    end
  end
end
