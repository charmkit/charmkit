namespace :php do
  desc "Install PHP"
  task :install do
    pkgs = [
      'php-fpm',
      'php-cgi',
      'php-curl',
      'php-gd',
      'php-json',
      'php-mcrypt',
      'php-readline',
      'php-mbstring',
      'php-xml'
    ]
    cmd.run "apt-get update"
    cmd.run "juju-log Installing PHP7 and its dependencies."
    cmd.run "apt-get install -qyf #{pkgs.join(' ')}"
  end
end
