module Charmkit
  module Helpers
    def status(level=:maintenance, msg="")
      levels = [:maintenance, :active, :blocked, :waiting]
      raise unless levels.include?(level)
      cmd.run "status-set #{level.to_s} '#{msg}'"
    end

    def config(item)
      out, err = cmd.run "config-get '#{item}'"
      return out.chomp
    end

    def resource(item)
      out, err = cmd.run "resource-get '#{item}'"
      return out.chomp
    end

    def unit(item)
      out, err = cmd.run "unit-get '#{item}'"
      return out.chomp
    end

    def action(item)
      out, err = cmd.run "action-get '#{item}'"
      return out.chomp
    end

    def action=(item)
      out, err = cmd.run "action-set '#{item}'"
      return out.chomp
    end

    def log(msg)
      cmd.run "juju-log #{msg}"
    end
  end
end
