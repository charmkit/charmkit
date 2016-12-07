namespace :nginx do
  desc "Install NGINX"
  task :install do
    cmd.run "apt-get", "update"
    cmd.run "juju-log", "Installing NGINX and its dependencies."
    cmd.run "apt-get", "install", "-qyf", "nginx-full"
  end
end
