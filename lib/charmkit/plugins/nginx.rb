namespace :nginx do
  desc "Install NGINX"
  task :install do
    `apt-get update`
    `juju-log "Installing NGINX and its dependencies."`
    `apt-get install -qyf nginx-full`
  end
end
