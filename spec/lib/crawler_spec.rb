# frozen_string_literal: true

module Finviz
  RSpec.describe Crawler do
    describe "::call" do
      let(:crawler) { instance_double described_class, fetch: nil, result: :result }
      before do
        allow(described_class).to receive(:new).and_return(crawler)
      end

      subject { described_class.call }

      it { is_expected.to eq(:result) }
    end

    describe "#fetch" do
      let(:paths) do
        %w[
          https://finviz.com/screener.ashx?v=211&f=geo_usa,ind_stocksonly,sh_curvol_o500&ft=4&r=0
          https://finviz.com/screener.ashx?v=211&f=geo_usa,ind_stocksonly,sh_curvol_o500&ft=4&r=15
        ]
      end

      subject { described_class.new paths: paths }

      before do
        subject.fetch
      end

      it "should fetch 2 pages" do
        expect(subject.result.size).to eq 2
      end

      it "fetch provided paths" do
        expect(subject.result.map(&:path)).to include(*paths)
      end

      it "fetch return parsed pages" do
        expect(subject.result.map(&:html)).to all(be_an(Nokogiri::HTML::Document))
      end
    end
  end
end
