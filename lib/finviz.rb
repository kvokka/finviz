# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup # ready!

require "dry-configurable"
require "active_support"
require "active_support/core_ext/hash/conversions"
require "nokogiri"
require "uri"
require "cgi"

# Main module containing the settings and top-level methods
module Finviz
  class Error < StandardError; end

  extend Dry::Configurable

  setting :timeout, 120 # seconds
  setting :quotes_fetcher do
    # Was manually found by feeding
    # Finviz::TickersFetcher.new.call.first(400).join(',')
    # to QuotesFetcher#uri method that max acceptable value is 400
    # prefer to keep it lower to increase concurrency
    setting :max_tickers_per_page, 100
  end

  class << self
    def tickers(**opts)
      TickersFetcher.new(**opts).call
    end
  end
end
