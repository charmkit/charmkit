require 'micromachine'
require 'yaml/store'


module Charmkit
  class Reactive
    extend Forwardable

    def_delegators :@fm, :on, :when, :trigger, :trigger!, :trigger?, :events, :states, :state

    def initialize
      @store = PStore.new('.ck.yml')
      @final_states = @store.transaction { @store.fetch(:final_states, [])}
      @fm = MicroMachine.new(:start)
    end

    def only_once(key, &block)
      return if @final_states.include?(key)
      @fm.on key, &block
      @final_states << key
      @store.transaction { @store[:final_states] = @final_states }
    end
  end
end
