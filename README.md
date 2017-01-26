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

In **hooks/install**:

```
#!/bin/sh

apt-get update
apt-get install -qyf ruby bundler --no-install-recommends
gem install bundler

bundle install --local --quiet --without development

bundle exec rake dokuwiki:install
```

In other hooks call relevant rake tasks (eg. **hooks/config-changed**)

```
#!/bin/sh

bundle exec rake dokuwiki:config_changed
```

Same for **hooks/upgrade-charm**

```
#!/bin/sh

bundle exec rake dokuwiki:upgrace_charm
```

## Writing Charmkit style hooks

All Charmkit hooks will reside in a normal **Rakefile**.

### Syntax

```ruby
require 'charmkit'

namespace :dokuwiki do

  desc "Install Dokuwiki"
  task :install do
    use :nginx
    use :php

    deps.install

    app_path = config 'app_path'
    resource_path = resource 'stable-release'
    hook_path = ENV['JUJU_CHARM_DIR']

    mkdir_p app_path

    run "tar", "xf", resource_path, "-C", app_path, "--strip-components=1"

    cp "#{hook_path}/templates/acl.auth.php", "#{app_path}/conf/acl.auth.php"
    cp "#{hook_path}/templates/local.php", "#{app_path}/conf/local.php"
    cp "#{hook_path}/templates/plugins.local.php", "#{app_path}/conf/plugin.local.php"

    version = File.read "#{app_path}/VERSION"
    run "application-version-set", version.chomp
    status :active, "Dokuwiki installed, please set your admin user and password with juju config dokuwiki admin_user=<an_admin_name> admin_password=<sha512 password>"
  end

  desc "Configure Dokuwiki"
  task :config_changed do
    app_path = config 'app_path'
    hook_path = ENV['JUJU_CHARM_DIR']

    admin_user = config 'admin_user'
    admin_password = config 'admin_password'
    admin_name = config 'admin_name'
    admin_email = config 'admin_email'
    template "#{hook_path}/templates/users.auth.php",
             "#{app_path}/conf/users.auth.php",
             admin_user: admin_user,
             admin_password: admin_password,
             admin_name: admin_name,
             admin_email: admin_email

    public_address = unit 'public-address'
    template "#{hook_path}/templates/vhost.conf",
             "/etc/nginx/sites-enabled/default",
             public_address: public_address,
             app_path: app_path

    chown_R 'www-data', 'www-data', app_path

    run "systemctl restart php7.0-fpm"
    run "systemctl restart nginx"
    run "open-port 80"
    status :active, "Dokuwiki updated and is now ready."
  end
end

task :default => 'dokuwiki:install'
```

The core of Charmkit contains a few helpers such as template rendering but otherwise kept relatively small.


## Packaging the Charm

```
$ bundle package
```

This will package and cache all required gems, along with making sure the necessary
scrolls are included.

## Uploading to charm store

Once the charm is built simply run:

```
$ charm push .
```

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
