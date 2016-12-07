require 'pstore'

class Scroll
  # def initialize
  #   @store = PStore.new('charmkit.store')
  #   @cache = @store.transaction { @store.fetch(:data, {:states => []})}
  # end
  # def self.summon(run_state, success_state, &block)
  #   puts "Setting run state: #{run_state}"
  #   self.store.transaction do
  #     @store[:data][:states] << run_state
  #   end
  #   block.call if block_given?
  #   puts "Setting successful state: #{success_state}"
  #   @store.transaction do
  #     @store[:data][:states] << success_state
  #   end
  # end
  class << self
    attr_accessor :summary
    attr_accessor :desc
    attr_accessor :depends_on

    def incant(run_state, success_state, &block)
      puts run_state
      block.call if block_given?
      puts success_state
    end
  end
end
