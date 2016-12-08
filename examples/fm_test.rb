require 'charmkit'
require 'finite_machine'
require 'yaml/store'
require 'pp'

machines = []

class Car
  def turn_reverse_lights_off
    @reverse_lights = false
  end

  def turn_reverse_lights_on
    @reverse_lights = true
  end

  def reverse_lights_on?
    @reverse_lights || false
  end

  def gears
    context = self
    @gears ||= FiniteMachine.define do
      initial :neutral

      target context

      events {
        event :start, :neutral => :one
        event :shift, :one => :two
        event :shift, :two => :one
        event :back,  [:neutral, :one] => :reverse
      }

      callbacks {
        on_enter :reverse do |event|
          target.turn_reverse_lights_on
        end

        on_exit :reverse do |event|
          target.turn_reverse_lights_off
        end

        on_transition do |event|
          puts "shifted from #{event.from} to #{event.to}"
        end
      }
    end
  end
end

class Camera
  def turn_reverse_lights_off
    @reverse_lights = false
  end

  def turn_reverse_lights_on
    @reverse_lights = true
  end

  def reverse_lights_on?
    @reverse_lights || false
  end

  def gears
    context = self
    @gears ||= FiniteMachine.define do
      initial :neutral

      target context

      events {
        event :start, :neutral => :one
        event :shift, :one => :two
        event :shift, :two => :one
        event :back,  [:neutral, :one] => :reverse
      }

      callbacks {
        on_enter :reverse do |event|
          target.turn_reverse_lights_on
        end

        on_exit :reverse do |event|
          target.turn_reverse_lights_off
        end

        on_transition do |event|
          puts "shifted from #{event.from} to #{event.to}"
        end
      }
    end
  end
end

# machines = [Car.new, Camera.new]

store = PStore.new('store.yml')
# store.transaction do
#   store[:machines] = machines
# end
machines = store.transaction { store[:machines] }

car = machines.first
# puts car.gears.current
# car.reverse_lights_on?
# car.gears.start
car.gears.back
puts car.gears.current

store.transaction do
  store[:machines].push car
end
