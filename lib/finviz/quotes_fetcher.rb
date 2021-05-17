module Finviz
  # Fetch the details of the security
  class QuotesFetcher

    def initialize tickers: []
      @tickers = Array(tickers)
    end

    attr_reader :tickers

    def call

    end

    private

    def uri(t)
      URI::HTTPS.build(host: 'finviz.com', path: '/quote.ashx', query: {t: t.join(',')}
    end
  end
end