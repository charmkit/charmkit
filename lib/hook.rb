class HookApplication
  def initialize
    @name = "install"
  end

  def name
    self.class.name
  end

  class << self
    attr_accessor :name
  end
end
