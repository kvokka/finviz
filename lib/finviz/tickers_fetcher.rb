# frozen_string_literal: true

module Finviz
  # Fetch the list of tickers basing on the provided uri or array of filters
  class TickersFetcher
    attr_reader :uri

    def initialize(uri: nil, filters: [], **rest)
      raise("You should provide either uri or filters") unless uri.present? ^ filters.present?
      raise("Do not support option #{rest.keys}") unless rest.empty?

      normalize_uri(uri, filters)
    end

    def call; end

    private

    def normalize_uri(uri, filters)
      uri = URI(uri || base_uri)
      query = CGI.parse(uri.query || "").tap do |params|
        params["f"] = filters&.join(",") if filters&.any?
        params["v"] = finviz_view_type
        params.delete("r") # remove offset if it was provided
      end.to_query
      @uri = URI::HTTPS.build(host: base_uri, path: base_path, query: query)
    end

    def base_uri
      "finviz.com"
    end

    def base_path
      "/screener.ashx"
    end

    # Output only tickers to reduce pages count
    def finviz_view_type
      411
    end
  end
end
