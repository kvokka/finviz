# frozen_string_literal: true

RSpec.describe Finviz do
  it "has a version number" do
    expect(Finviz::VERSION).not_to be nil
  end

  describe "::tickers" do
    let(:klass) { Finviz::TickersFetcher }
    let(:uri) { "http://foo" }
    before do
      allow(klass).to receive(:new).with(uri: uri).and_return(instance_double(klass, call: true))
    end

    subject { described_class.tickers uri: uri }

    it "should forward to tickers fetcher" do
      is_expected.to be_truthy
    end

    it "is expected to receive uri option" do
      subject
      expect(klass).to have_received(:new).with(uri: uri)
    end
  end
end
