# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup # ready!

require "dry-configurable"
require "active_support"

# Main module containing the settings and top-level methods
module Finviz
  class Error < StandardError; end

  extend Dry::Configurable

  setting :timeout, 10 # seconds

  class << self
    def tickers(**opts)
      TickersFetcher.new(**opts).call
    end
  end
end
