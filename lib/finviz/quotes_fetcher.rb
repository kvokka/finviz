# frozen_string_literal: true

module Finviz
  # Fetch the details of the security
  class QuotesFetcher
    def self.dangerous_methods
      @dangerous_methods ||= OpenStruct.instance_methods
                                       .map(&:to_s)
                                       .select { |m| m.length <= 5 }
                                       .reject { |m| m =~ /!|\?|>|<|=|_|\[|\]/ }
    end

    def initialize(tickers: [])
      @tickers = Array(tickers)
    end

    attr_reader :tickers

    # rubocop:disable Style/DocumentDynamicEvalDefinition
    def call
      Quotes.new.tap do |result|
        all_pages.each do |page|
          page.html.css("#ticker").zip(page.html.css(".snapshot-table2")).each do |(ticker_xpath, table_xpath)|
            result.add_quote_from_xpath(ticker_xpath, table_xpath)
          end
        end

        self.class.dangerous_methods.each { |m| result.instance_eval("undef :#{m}", __FILE__, __LINE__) }
      end
    end
    # rubocop:enable Style/DocumentDynamicEvalDefinition

    private

    def all_pages
      @all_pages ||= Crawler.call(paths: paths)
    end

    def paths
      @paths ||= tickers
                 .each_slice(Finviz.config.quotes_fetcher.max_tickers_per_page)
                 .map { |slice| uri slice }
    end

    def uri(tickers_array)
      query = CGI.unescape(URI.encode_www_form({ t: tickers_array.join(",") }))
      URI::HTTPS.build(host: "finviz.com", path: "/quote.ashx", query: query)
    end
  end
end
