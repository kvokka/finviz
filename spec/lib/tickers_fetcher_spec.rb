# frozen_string_literal: true

module Finviz
  RSpec.describe TickersFetcher do
    describe "::new" do
      context "should be fine if only 1 option provided" do
        it "uri" do
          expect(described_class.new(uri: "http://foo")).to be_a described_class
        end

        it "filters" do
          expect(described_class.new(filters: ["some"])).to be_a described_class
        end
      end

      context "should raise" do
        it "if uri and filters provided" do
          expect { described_class.new filters: ["some"], uri: "http://foo" }.to raise_error StandardError
        end

        it "if unsupported option provided" do
          expect { described_class.new wrong: 42 }.to raise_error StandardError
        end
      end

      context "it build right uri with uri option" do
        let(:correct) do
          "https://finviz.com/screener.ashx?v=411&f=geo_usa,ind_stocksonly,sh_curvol_o500,sh_relvol_o2&ft=4"
        end
        %w[
          https://finviz.com/screener.ashx?v=411&f=geo_usa,ind_stocksonly,sh_curvol_o500,sh_relvol_o2&ft=4&r=61
          finviz.com/screener.ashx?v=411&f=geo_usa,ind_stocksonly,sh_curvol_o500,sh_relvol_o2&ft=4&r=61
          screener.ashx?v=411&f=geo_usa,ind_stocksonly,sh_curvol_o500,sh_relvol_o2&ft=4&r=61
          http://finviz.com/screener.ashx?v=411&f=geo_usa,ind_stocksonly,sh_curvol_o500,sh_relvol_o2&ft=4&r=61
          https://ololo.com/zooo.ashx?v=411&f=geo_usa,ind_stocksonly,sh_curvol_o500,sh_relvol_o2&ft=4&r=61
          https://finviz.com/screener.ashx?v=666&f=geo_usa,ind_stocksonly,sh_curvol_o500,sh_relvol_o2&ft=4&r=61
        ].each_with_index do |uri, i|
          it "works as expected with line #{i}" do
            expect(described_class.new(uri: uri).uri.to_s).to eq correct
          end
        end
      end

      context "it build right uri with filters option" do
        let(:correct) do
          "https://finviz.com/screener.ashx?f=fil1,some2&v=411"
        end
        it "works as expected" do
          expect(described_class.new(filters: %w[fil1 some2]).uri.to_s).to eq correct
        end
      end
    end

    describe "::call" do
      context "with pagination" do
        # VCS timeout some queries, so we are ok that we r testing partly in here
        it "should fetch 1k+ of tickers" do
          expect(subject.call.size).to be > 1_000
        end

        it "should be array of strings" do
          expect(subject.call).to all(be_an(String))
        end
      end
    end
  end
end
