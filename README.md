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
apt-get install -qyf ruby --no-install-recommends
gem install bundler

bundle install --local --quiet

# Runs the lib/install.rb hook
bundle exec charmkit hook install
```

In other hooks call *charmkit* with the execing hook (eg. **hooks/config-changed**)

```
#!/bin/sh

bundle exec charmkit hook config-changed
```

Same for **hooks/upgrade-charm**

```
#!/bin/sh

bundle exec charmkit upgrade-charm
```

## Writing Charmkit style hooks

All Charmkit hooks must reside in the charm's toplevel **lib/** directory. Those
files must match the name of the hook you want to assicate to and must end with
a **.rb** extension.

For example, if my hook runs `bundle exec charmkit config-changed` then in my
**lib/** directory should exist a file named **lib/config-changed.rb**.

To start, you'll want to inherit from the **Charmkit** class. The class name should also
reflect the name of the hook being executed and should be in a standard Ruby camelcase style.

See the syntax below for a the **config-changed** hook being run:

### Syntax

```ruby
class ConfigChanged < Charmkit::Hook
  use :nginx

  summon do
    package [
        'php-fpm',      'php-cgi',      'php-curl', 'php-gd', 'php-json',
        'php-mcrypt', 'php-readline', 'php-mbstring', 'php-xml'
    ], :update_cache

    hook_path = ENV['JUJU_CHARM_DIR']
    app_path = path(config('app_path'))

    mkdir app_path

    resource_path = path(resource('stable-release'))
    run "tar xf #{resource_path} -C #{app_path} --strip-components=1"

    rm app_path/"conf/install.php"
    status :active, "Dokuwiki configuration updated."
  end

  test do
    cmd.test '-e /etc/passwd'
  end
end
```

The core of Charmkit is relatively small and everything is handled through
scrolls (read
plugins). [Visit Charmkit Scrolls](https://github.com/charmkit/charmkit-scrolls)
for more information.


## Packaging the Charm

```
$ bundle exec charmkit build
```

This will package and cache all required gems, along with making sure the necessary
scrolls are included. The output will be a charm that you can deploy via:

```
$ juju deploy dist/.
```

## Uploading to charm store

Once the charm is built simply run:

```
$ charm push dist/.
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
