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
  end
end
