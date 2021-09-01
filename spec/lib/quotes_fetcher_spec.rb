# frozen_string_literal: true

module Finviz
  TICKERS = %w[a m c tap].freeze
  RSpec.describe QuotesFetcher do
    describe "#call" do
      let(:tickers) { TICKERS }
      before do
        allow(Finviz.config.quotes_fetcher).to receive(:max_tickers_per_page).and_return(2)
      end

      subject { described_class.new(tickers: tickers).call }

      it "should fetch 4 tickers" do
        expect(subject.to_h.size).to eq tickers.size
      end

      TICKERS.each do |ticker|
        it "#{ticker} should respond to ticker method" do
          expect(subject.public_send(ticker)).to be_a Quote
        end

        it "#{ticker} should respond to ticker key" do
          expect(subject[ticker]).to be_a Quote
        end
      end
    end
  end
end
