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
      out, err = run "config-get #{item}"
      return out.chomp
    end

    def resource(item)
      out, err = run "resource-get #{item}"
      return out.chomp
    end

    def unit(item)
      out, err = run "unit-get #{item}"
      return out.chomp
    end

    def action(item)
      out, err = run "action-get #{item}"
      return out.chomp
    end

    def action=(item)
      out, err = run "action-set #{item}"
      return out.chomp
    end

    def log(msg)
      run "juju-log #{msg}"
    end
  end
end
