require 'fileutils'

module Charmkit
  module DSL
    def file(src, content:)
      File.write(src, content)
    end

    def is_file?(path)
      return File.exists?(path)
    end

    def is_dir?(path)
      return Dir.exists?(path)
    end

    def mkdir(path)
      FileUtils.mkdir_p path unless is_dir? path
    end
  end
end
