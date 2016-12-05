require "charmkit/version"
require "charmkit/helpers/template"

module Charmkit
  # A generic exception by Charmkit
  class Error < StandardError; end
end
extend Charmkit::Helpers
