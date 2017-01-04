require "active_support/core_ext/string/inflections"
require 'pathname'
require 'thor'
require 'charmkit/helpers'
require 'charmkit/dependencies'

module Charmkit
  class CLI < Thor
    desc "hook NAME", "execute a given hook"
    def hook(name)
      if File.exists?("./lib/#{name}.rb")
        require "./lib/#{name}"
      else
        puts "Could not find hook in ./lib/#{name}.rb"
        exit 1
      end

      # Perform the Hook's tasks
      hook = Object.const_get(name.underscore.camelize.classify).new

      if defined? Install and hook.is_a? Install
        Dependencies.install
      end

      if hook.respond_to? :summon
        hook.summon
      end

      if hook.respond_to? :test
        hook.test
      end
    end

    desc "update", "Update scrolls registry"
    def update
      cache_path = Pathname(ENV['HOME'])/'.cache/'
      registry_path = cache_path.join('charmkit-scrolls')
      if registry_path.directory? and registry_path.join('.git').directory?
        system "cd #{registry_path} && git pull -q"
      else
        cache_path.mkpath
        system "cd #{cache_path} && git clone -q --depth=1 https://github.com/charmkit/charmkit-scrolls.git"
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
        pn.join('lib').mkpath
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
        Helpers.inline_template 'generic-hook', hook_path, hook: hook
        hook_path.chmod 0755
      end

      Helpers.inline_template 'install.rb', pn/'lib/install.rb'
    end
    map "g" => "generate"
  end
end


__END__

@@ Gemfile
# frozen_string_literal: true
source "https://rubygems.org"

gem "charmkit"

# If you wish to load additional scrolls add those here
# gem "charmkit-scroll-nginx", :github => "battlemidget/charmkit-scroll-nginx"

@@ install.rb
require 'charmkit'

# This is your install hook
class Install < Charmkit::Hook
  use :nginx  # If you want to make use of scrolls you'll define them here

  # This method must be defined for the hook to execute
  # You have access to the scrolls based on the constant name
  # ie. the symbol :nginx would translate to the constant Nginx, see below
  # for an example
  def summon
    Nginx.add_host server_name: "www.example.com"
  end
end

@@ install-hook
#!/bin/sh
apt-get update && apt-get install -qyf ruby bundler --no-install-recommends
bundle install --local --quiet --without development
# Do install task
bundle exec charmkit install

@@ generic-hook
#!/bin/sh
bundle exec charmkit <%= hook %>

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

How developers can contribute

# Maintainers

How QA and others can test your charm

# Author

Your name <mememe@email.com>

# Copyright

2016 Your name

# License

MIT
