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
      FileUtils.mkdir_p path
    end

    def rm(path)
      FileUtils.rm_rf(path, :force => true)
    end
  end
end
