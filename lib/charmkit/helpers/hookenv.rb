module Charmkit
  module Helpers
    # Hook path within a charm execution
    #
    # @return [String]
    def hook_path
      ENV['JUJU_CHARM_DIR']
    end

    def status(level=:maintenance, msg="")
      levels = [:maintenance, :active, :blocked, :waiting]
      raise unless levels.include?(level)
      sh "status-set #{level.to_s} '#{msg}'"
    end

    def config(item)
      out, err = sh "config-get '#{item}'"
      return out.chomp
    end

    def resource(item)
      out, err = sh "resource-get '#{item}'"
      return out.chomp
    end

    def unit(item)
      out, err = sh "unit-get '#{item}'"
      return out.chomp
    end

    def action(item)
      out, err = sh "action-get '#{item}'"
      return out.chomp
    end

    def action=(item)
      out, err = sh "action-set '#{item}'"
      return out.chomp
    end

    def log(msg)
      sh "juju-log #{msg}"
    end
  end
end
