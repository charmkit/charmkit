require 'fileutils'

module Charmkit
  module DSL
    FileUtils.singleton_methods.each do |m|
      define_method m, FileUtils.method(m).to_proc
    end
    def is_file?(path)
      return File.exists? path
    end
    def is_dir?(path)
      return Dir.exists? path
    end
    def spew(dst, content)
      File.write(dst, content)
    end
    def slurp(src)
      return File.read(src)
    end
  end
end
