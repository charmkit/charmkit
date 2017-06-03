require "active_support/core_ext/string/inflections"
require 'pathname'
require 'thor'
require 'charmkit'
require 'charmkit/helpers'
require 'charmkit/dependencies'

module Charmkit
  class CLI < Thor
    desc "build", "builds a charm"
    def build
      pn = Pathname('Charmkitfile')
      if pn.exist?
        puts "Building charm"
      end
    end

    desc "generate NAME", "generate a charm skelton"
    def generate(name)
      pn = Pathname(name)
      if pn.directory?
        puts "#{name} directory exists, please choose a different charm name."
        exit 1
      else
        pn.mkpath
        pn.join('hooks').mkpath
      end
      Helpers.inline_template 'config.yaml', pn/'config.yaml'
      Helpers.inline_template 'metadata.yaml', pn/'metadata.yaml', name: name
      Helpers.inline_template 'README.md', pn/'README.md', name: name
      Helpers.inline_template 'Gemfile', pn/'Gemfile'

      # Write the install hook
      hook_path = pn.join('hooks/install')
      Helpers.inline_template 'install-hook', hook_path
      hook_path.chmod 0755

      # Write other hooks
      hooks = ['config-changed',
               'upgrade-charm',
               'start',
               'stop',
               'leader-elected',
               'leader-settings-changed',
               'update-status']
      hooks.each do |hook|
        hook_path = pn.join("hooks/#{hook}")
        Helpers.inline_template 'generic-hook', hook_path, hook: hook.underscore
        hook_path.chmod 0755
      end

      Helpers.inline_template 'Rakefile', pn/'Rakefile'
    end
    map "g" => "generate"
  end
end


__END__

@@ Gemfile
# frozen_string_literal: true
source "https://rubygems.org"

gem "charmkit"
gem "rake"
gem "rspec"

# If you wish to load additional scrolls add those here
# gem "charmkit-scrolls-nginx", :github => "battlemidget/charmkit-scrolls-nginx"

@@ Rakefile
require 'charmkit'

desc "Install hook"
task :install do
  use :nginx
  nginx.add_host server_name: "example.com"
end

@@ install-hook
#!/bin/sh
apt-get update && apt-get install -qyf ruby bundler --no-install-recommends
bundle install --local --quiet --without development
# Do install task
bundle exec rake install

@@ generic-hook
#!/bin/sh
bundle exec rake <%= hook %>

@@ config.yaml
options: {}

@@ metadata.yaml
name: <%= name %>
summary: |
  <<insert summary>>
description: |
  <<insert description>>
maintainers: ['']
series:
  - xenial

@@ README.md
# Overview

My charm Overview

# Usage

    $ juju deploy <%= name %>

# Developers

This charm uses Rake (a make like utility) for defining hooks and can be seen in
the **Rakefile**. It also uses a simple library **Charmkit** for providing some
additional helper methods such as templating.

To learn more visit [Charmkit](https://github.com/charmkit/charmkit).

# Maintainers

## Testing

The tests cover installation and verification that your charm is installed and
running correctly.

## Ways to run the tests

### Use bundletester

```
sudo bundletester -F -t cs:~charmers/charm -l DEBUG -v -r json -o /tmp/results.json
```

### Run tests via Ruby bundler

```
bundle install --local --with development
bundle exec ./tests/verify
```

A few package dependencies are required for testing locally, have a look in **tests/tests.yaml** for those package names.

# Author

Your name <mememe@email.com>

# Copyright

2017 Your name

# License

MIT
