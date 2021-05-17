# frozen_string_literal: true

module Finviz
  # Fetch the details of the security
  class QuotesFetcher
    def initialize(tickers: [])
      @tickers = Array(tickers)
    end

    attr_reader :tickers

    def call
      add_stats_to_results
      add_charts_to_results
      results.flatten!
    end

    private

    def add_stats_to_results
      all_pages.each_with_index do |page, page_number|
        page.html.css(".snapshot-table2").each_with_index do |xpath, selector_offset|
          current = results[page_number][selector_offset]
          current.stats = xpath.css(".table-dark-row").map { |row| row.css("td").map(&:text) }
                               .flatten.each_slice(2).to_h
        end
      end
    end

    def add_charts_to_results
      all_pages.each_with_index do |page, page_number|
        page.html.css("#chart1").each_with_index do |xpath, selector_offset|
          current = results[page_number][selector_offset]
          current.chart = xpath.attributes["src"].text
        end
      end
    end

    def results
      @results ||= all_pages.map do |page|
        page.html.css("#ticker").map do |xpath|
          ticker = xpath.children.text
          OpenStruct.new path: "https://finviz.com/quote.ashx?t=#{ticker}",
                         ticker: ticker,
                         chart: "https://charts2.finviz.com/chart.ashx?t=#{ticker}&ty=c&ta=1&p=d&s=l"
        end
      end
    end

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
