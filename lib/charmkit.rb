require "yaml"
require "charmkit/version"
require 'charmkit/helpers'
require 'charmkit/extend/struct_tools'
require 'active_support/core_ext/hash/keys'

module Charmkit
  include Helpers

  attr_reader :dependencies, :resources, :options

  def name(name)
    @name = name
  end

  def summary(text)
    @summary = text
  end

  def description(text)
    @description = text
  end

  def maintainers(*people)
    @maintainers = people.to_a
  end

  def series(*series)
    @series = series.to_a
  end

  def tags(*tags)
    @tags = tags.to_a
  end

  def resource(item)
    case item.class
    when String
      resource_get item
    when Hash
      @resources << item.stringify_keys!
    end
  end

  def option(k, v = {})
    opts = {}
    opts[k] = {
      'default' => "",
      'type' => "string",
      'description' => ""
    }
    opts[k].merge!(v)
    @options << opts.deep_stringify_keys!
  end

  def self.extended(by)
    by.instance_exec do
      @dependencies = []
      @resources = []
      @options = []
    end
  end

  # Deb package list that plugin requires
  #
  # @attr [String] name The name of deb package
  # @attr [Symbol] state The state of package once installed
  Package = Struct.new(:name,
                       :state)

  def depends_on(pkg, options = {})
    options = {
      :state => :installing
    }.merge(options)
    package = Package.new(pkg, *options.values_at(:state))
    @dependencies << package
    package
  end

  def hook(name, &block)
    case name
    when "install"
      puts "Doing apt-get install"
    end
    puts "Executing #{name}"
  end

  private
  def save_metadata
    meta = {
      'name' => @name,
      'summary' => @summary,
      'description' => @description,
      'maintainers' => @maintainers,
      'series' => @series,
      'tags' => @tags,
      'resources' => @resources
    }
    file "metadata.yaml", meta.to_yaml
  end

  def save_config
    opts = {
      'options' => @options
    }
    file "config.yaml", opts.to_yaml
  end


end
extend Charmkit
