module Charmkit
  def self.version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 0
    MINOR = 4
    PATCH = 8
    PRE = nil

    STRING = [MAJOR, MINOR, PATCH, PRE].compact.join('.')
  end
end
