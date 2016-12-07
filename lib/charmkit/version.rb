module Charmkit
  def self.version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 0
    MINOR = 4
    PATCH = 5
    PRE = nil

    STRING = [MAJOR, MINOR, PATCH, PRE].compact.join('.')
  end
end
