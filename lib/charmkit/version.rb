module Charmkit
  def self.version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 0
    MINOR = 3
    PATCH = 9
    PRE = nil

    STRING = [MAJOR, MINOR, PATCH, PRE].compact.join('.')
  end
end
