# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup # ready!

require "dry-configurable"

# Main module containing the settings and top-level methods
module Finviz
  class Error < StandardError; end

  extend Dry::Configurable

  setting :timeout, 10 # seconds
end
