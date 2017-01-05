class ConfigChanged < Charmkit::Hook
  use :php

  summon do
    php.setup_php site_path: "/srv"
  end

  test do
    run 'ls -l /home'
  end
end
