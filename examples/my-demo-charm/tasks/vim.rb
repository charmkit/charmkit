# The local task provide with the charm itself

namespace :vim do
  desc "Install VIM"
  task :install do
    system("apt-get install -qyf vim")
  end
end
