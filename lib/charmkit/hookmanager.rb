module Charmkit
  class HookManager
    include Enumerable
    @@hooks = {}
    def self.empty?
      @@hooks.empty?
    end

    def self.set(name, &block)
      @@hooks[name] = block
      self
    end

    def self.get(name)
      @@hooks[name]
    end

    def self.to_s
      puts @@hooks
    end
  end
end
