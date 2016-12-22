class Dependencies
  include Enumerable

  @@deps = []

  def self.empty?
    @@deps.empty?
  end

  def self.install
    # TODO: Should be a dependency class with options for
    # installing groups, recommended packages, and snaps
    puts "Installing #{@@deps.join(' ')}"
  end

  def self.<<(o)
    @@deps << o
    self
  end

  def self.to_s
    @@deps.join(' ')
  end
end
