require 'charmkit'

class ConfigChanged < Charmkit::Hook
  use :php

  php.setup_php site_path: "/srv"
end
