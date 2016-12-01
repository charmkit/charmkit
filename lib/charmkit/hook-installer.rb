module Charmkit
  class HookInstaller
    include FileUtils
    attr :url
    attr :bugs
    def run
      puts "URL: #{url}"
      puts "BUGS: #{bugs}"
    end
  end
end
