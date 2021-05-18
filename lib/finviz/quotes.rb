# frozen_string_literal: true

module Finviz
  # The result of the quotes request
  class Quotes < OpenStruct
    def add_quote_from_xpath(ticker_xpath, table_xpath)
      ticker = ticker_xpath.children.text.downcase
      stats = table_xpath
              .css(".table-dark-row")
              .map { |row| row.css("td").map(&:text) }
              .flatten
              .each_slice(2)
      self[ticker] = Quote.new ticker: ticker, stats: stats
    end

    def to_h
      super.transform_values(&:to_h)
    end
  end
end
