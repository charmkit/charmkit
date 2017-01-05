class Install < Charmkit::Hook
  use :nginx
  use :php, alias: "web"

  summon do
    nginx.add_host server: "bong.com"
    web.setup_php hai: "stfu"
  end

  test do
    puts "running some tests"
  end
end
