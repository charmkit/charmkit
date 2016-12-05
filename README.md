# Charmkit [![Gem Version](https://badge.fury.io/rb/charmkit.svg)](https://badge.fury.io/rb/charmkit)
> elegantly elegant charm authoring

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'charmkit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install charmkit

## Usage

Define all install, configure, upgrade tasks within a normal **Rakefile**. The
hooks will then need to just call those tasks:

In **hooks/install**:

```
#!/bin/sh

apt-get update
apt-get install -qyf ruby --no-install-recommends
gem install bundler

bundle install --local --quiet

# Runs the lib/install.rb hook
bundle exec rake dokuwiki:install
```

In other hooks call *charmkit* with the execing hook (eg. **hooks/config-changed**)

```
#!/bin/sh

bundle exec rake dokuwiki:config_changed
```

Same for **hooks/upgrade-charm**

```
#!/bin/sh

bundle exec rake dokuwiki:install
bundle exec rake dokuwiki:config_changed

```

## Writing Charmkit style hooks

All Charmkit hooks will reside in a normal **Rakefile**.

### Syntax

```ruby
namespace :dokuwiki do

  desc "Install required apt packages"
  task :install_deps do
    pkgs = [
      'nginx-full', 'php-fpm',      'php-cgi',      'php-curl', 'php-gd', 'php-json',
      'php-mcrypt', 'php-readline', 'php-mbstring', 'php-xml'
    ]
    `apt-get update`
    `apt-get install -qyf #{pkgs.join(' ')}`
  end

  desc "Install Dokuwiki"
  task :install => [:install_deps] do
    app_path = `config-get app_path`
    resource_path = `resource-get stable-release`
    hook_path = ENV['JUJU_CHARM_DIR']

    mkdir_p app_path unless Dir.exists? app_path

    `tar xf #{resource_path} -C #{app_path} --strip-components=1`
    rm "#{app_path}/conf/install.php" if File.exists? "#{app_path}/conf/install.php"
    cp "#{hook_path}/templates/acl.auth.php", "#{app_path}/conf/acl.auth.php"
    cp "#{hook_path}/templates/local.php", "#{app_path}/conf/local.php"
    cp "#{hook_path}/templates/plugins.local.php", "#{app_path}/conf/plugin.local.php"

    version = File.read "#{app_path}/VERSION"
    `application-version-set '#{version}'`
    `status-set active Dokuwiki Install finished.`
  end

  desc "Configure Dokuwiki"
  task :config_changed do
    app_path = `config-get app_path`
    hook_path = ENV['JUJU_CHARM_DIR']

    admin_user = `config-get #{admin_user}`
    admin_password = `config-get admin_password`
    admin_name = `config-get admin_name`
    admin_email = `config-get admin_email`
    template "#{hook_path}/templates/users.auth.php",
             "#{app_path}/conf/users.auth.php",
             admin_user: admin_user,
             admin_password: admin_password,
             admin_name: admin_name,
             admin_email: admin_email

    template "#{hook_path}/templates/vhost.conf",
             "/etc/nginx/sites-enabled/default",
             public_address: unit('public-address'),
             app_path: app_path

    chown_R 'www-data', 'www-data', app_path

    # TODO: service :restart, "nginx"
    # TODO: service :restart, "php7.0-fpm"
    `systemctl restart php7.0-fpm`
    `systemctl restart nginx`
    `status-set active Ready`
  end
end
```

The core of Charmkit contains a few helpers such as template rendering but
otherwise kept relatively small.

## Packaging the Charm

You'll want to make sure that any Ruby gems used are packaged with your charm so
that you aren't forcing users to try to download those dependencies during
deployment.

Easiest way to package your deps is:

```
$ bundle package
```

This will place your deps inside `vendor/cache` which will be uploaded when
executing a `charm push .`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file
to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/charmkit/charmkit. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of
the [MIT License](http://opensource.org/licenses/MIT).
