class Charmkit
  module Scrolls
    module VimScroll
      module ClassMethods
        def vim(switch, &block)
          if switch == :install
            puts "install vim"
          end
          block.call if block_given?
        end
      end
    end
    register_scroll(:vim, VimScroll)
  end
end
