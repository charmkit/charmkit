module Charmkit
  module DSL
    # installs apt packages
    def package(packages, *opts)
      if opts.include?(:update_cache)
        run "apt-get update"
      end
      run "apt-get install -qyf #{packages.join(' ')}"
    end

    def is_installed?(package)
      begin
        run "dpkg -s #{package}" and return true
      rescue
        return false
      end
    end
  end
end
