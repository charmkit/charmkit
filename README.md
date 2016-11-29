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
#!/bin/bash

apt-get update
apt-get install -qyf ruby
gem install bundler

bundle install --standalone
```

In other hooks (eg. **hooks/config-changed**)

```ruby
#!/usr/bin/env ruby
require_relative '../bundle/bundler/setup'
require 'charmkit'

package [
    'nginx-full', 'php-fpm',      'php-cgi',      'php-curl', 'php-gd', 'php-json',
    'php-mcrypt', 'php-readline', 'php-mbstring', 'php-xml'
  ], :update_cache

hook_path = ENV['JUJU_CHARM_DIR']
app_path = config 'app_path'

mkdir app_path unless is_dir? app_path

release = config 'release'

case release
when "stable"
  resource_path = resource 'stable-release'
when "development"
  resource_path = resource 'development-release'
else
  status :blocked, "Unknown release given #{release}"
  exit 1
end

run "tar xf #{resource_path} -C #{app_path} --strip-components=1"

rm "#{app_path}/conf/install.php" unless !is_file? "#{app_path}/conf/install.php"
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

