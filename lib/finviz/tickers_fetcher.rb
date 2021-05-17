# frozen_string_literal: true

module Finviz
  # Fetch the list of tickers basing on the provided uri or array of filters
  class TickersFetcher
    attr_reader :uri

    def initialize(uri: nil, filters: [], **rest)
      raise("You should provide either uri or filters") if uri.present? && filters.present?
      raise("Do not support option #{rest.keys}") unless rest.empty?

      normalize_uri(uri, filters)
    end

    def call
      all_pages = first_page + remaining_pages
      all_pages
        .map { |p| p.html.css("table span[onclick]") }
        .flatten
        .map { |a| a.children.text.gsub(/[[:space:]]+/, "") }
    end

    private

    def first_page
      @first_page ||= Crawler.call(paths: uri)
    end

    def remaining_pages
      return @remaining_pages if @remaining_pages

      max_page = first_page.first.html.css("a.screener-pages").map { |a| a.children.text.to_i }.max
      paths = generate_further_pages(max_page)
      @remaining_pages = Crawler.call(paths: paths)
    end

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

    # In tickers view we can get 1k of tickers per request.
    # It is hardcoded be finviz
    def per_page
      1_000
    end

    def generate_further_pages(number)
      (1...number).map do |i|
        uri.dup.tap do |inner_uri|
          new_query_ar = URI.decode_www_form(inner_uri.query) << ["r", i * per_page + 1]
          inner_uri.query = URI.encode_www_form(new_query_ar)
        end
      end
    end
  end
end
