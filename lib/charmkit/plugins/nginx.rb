namespace :nginx do
  desc "Install NGINX"
  task :install do
    `apt-get update`
    `apt-get install nginx-full`
  end
end
