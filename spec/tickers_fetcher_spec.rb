# frozen_string_literal: true

module Finviz
  RSpec.describe TickersFetcher do
    describe "::new" do
      context "should be fine if only uri provided" do
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

        it "if nothing useful provided" do
          expect { described_class.new }.to raise_error StandardError
        end

        it "if unsupported option provided" do
          expect { described_class.new wrong: 42 }.to raise_error StandardError
        end
      end
    end
  end
end
