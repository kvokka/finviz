# frozen_string_literal: true

module Finviz
  # Fetch the list of tickers basing on the provided uri or array of filters
  class TickersFetcher
    attr_reader :uri, :filters

    def initialize(uri: nil, filters: [], **rest)
      @uri = uri
      @filters = filters
      raise("You should provide either uri or filters") unless uri.present? ^ filters.present?
      raise("Do not support option #{rest.keys}") unless rest.empty?
    end

    def call; end
  end
end
