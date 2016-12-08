require "charmkit/version"
require "charmkit/scroll"
require "pstore"

module Charmkit
  class State
    attr_reader :store

    def initialize
      @store = PStore.new('charmkit.store')
    end

    def get(state)
      if state == :all
        @store.transaction { @store.fetch(:data, []) }
      else
        @store.transaction { @store[:data][state] }
      end
    end

    def set(state)
      @store.transaction do
        @store[:data].append state
      end
    end

    def remove(state)
      @store.transaction do
        @store[:data].delete(state)
      end
    end
  end
end
