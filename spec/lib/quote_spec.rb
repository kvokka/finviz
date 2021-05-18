# frozen_string_literal: true

module Finviz
  RSpec.describe Quote do
    subject { described_class.new ticker: "a" }
    describe "#path" do
      it "should follow the pattern" do
        expect(subject.path).to eq "https://finviz.com/quote.ashx?t=a"
      end
    end
    describe "#chart" do
      it "should follow the pattern" do
        expect(subject.chart).to eq "https://charts2.finviz.com/chart.ashx?t=a&ty=c&ta=1&p=d&s=l"
      end
    end

    describe "#to_h" do
      let(:result) { {} }
      it "should build hash" do
        expect(subject.to_h).to include(chart: a_kind_of(String),
                                        path: a_kind_of(String),
                                        ticker: a_kind_of(String),
                                        stats: a_kind_of(ActiveSupport::HashWithIndifferentAccess))
      end
    end
  end
end
