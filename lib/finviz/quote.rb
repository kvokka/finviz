# frozen_string_literal: true

require "active_support/hash_with_indifferent_access"

module Finviz
  # Single quote representation
  class Quote
    attr_reader :ticker, :stats

    def initialize(ticker:, stats: nil)
      @ticker = ticker
      @stats = ActiveSupport::HashWithIndifferentAccess.new(stats.to_h)
    end

    def path
      "https://finviz.com/quote.ashx?t=#{ticker}"
    end

    def chart
      "https://charts2.finviz.com/chart.ashx?t=#{ticker}&ty=c&ta=1&p=d&s=l"
    end

    # grab all instance methods to the hash
    def to_h
      (self.class.instance_methods(false) - [__callee__]).each_with_object({}) do |method, acc|
        acc[method] = public_send method
      end
    end
  end
end
