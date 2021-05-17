# frozen_string_literal: true

module Finviz
  RSpec.describe QuotesFetcher do
    describe "#call" do
      let(:tickers) { %w[a m c] }
      before do
        allow(Finviz.config.quotes_fetcher).to receive(:max_tickers_per_page).and_return(2)
      end

      subject { described_class.new(tickers: tickers).call }

      it "should fetch all tickers" do
        expect(subject.size).to eq tickers.size
      end

      it "all tickers should contain stats" do
        expect(subject.map(&:stats)).to all(be_a Hash)
      end

      it "all tickers should contain chart" do
        expect(subject.map(&:chart)).to all(be_a String)
      end
    end
  end
end
