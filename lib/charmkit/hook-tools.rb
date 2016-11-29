# Hook tools module for exposing things such as status-set and action-set
module Charmkit
  module DSL
    # calls status-set in juju environment
    def status(level=:maintenance, msg="")
      levels = [:maintenance, :active, :blocked]
      raise unless levels.include?(level)
      run "status-set #{level.to_s} #{msg}"
    end

    def config(item)
      run "config-get #{item}"
    end

    def resource(item)
      run "resource-get #{item}"
    end

    def unit(item)
      run "unit-get #{item}"
    end

  end
end
