require "yaml"
require "charmkit/version"
require 'charmkit/helpers'
require 'charmkit/extend/struct_tools'

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
    @resources << item
  end

  def option(k, v = {})
    opts = {
      "#{k}": {
        default: "",
        type: "string",
        description: ""
      }
    }
    opts[k].merge!(v)
    @options << opts
  end

  def self.extended(by)
    by.instance_exec do
      @dependencies = []
      @resources = []
      @options = []
    end
  end

  # Hook path within a charm execution
  #
  # @return [String]
  def hook_path
    ENV['JUJU_CHARM_DIR']
  end


  # Deb package list that plugin requires
  #
  # @attr [String] name The name of deb package
  # @attr [Symbol] state The state of package once installed
  Package = Struct.new(:name,
                       :state)

  def depends_on(pkg, options = {})
    options = {
      :state => :installed
    }.merge(options)
    package = Package.new(pkg, *options.values_at(:state))
    @dependencies << package
    package
  end

  # Defines states that the plugin will react to
  # @param [Symbol] state A state that the plugin to should react to
  #
  # @return [Array<States>]
  # @example
  #   react_to :nginx_available, :install_app

  def react_to(state)
    puts "reacting to #{state}"
  end

  private
  def save_metadata
    meta = {
      name: @name,
      summary: @summary,
      description: @description,
      maintainers: @maintainers,
      series: @series,
      tags: @tags,
      resources: @resources
    }
    puts "saving metadata.yaml: \n#{meta.to_yaml}"
  end

  def save_config
    opts = {
      options: @options
    }
    puts "saving config.yaml: \n#{opts.to_yaml}"
  end


end
extend Charmkit
