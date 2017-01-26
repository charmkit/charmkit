module Charmkit
  class Dependencies
    include Enumerable

    @@deps = []

    def self.empty?
      @@deps.empty?
    end

    def self.install
      `apt-get install -qyf #{@@deps.join(' ')}`
    end

    def self.<<(o)
      @@deps << o
      self
    end

    def self.to_s
      @@deps.join(' ')
    end
  end
end
