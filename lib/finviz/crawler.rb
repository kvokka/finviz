# frozen_string_literal: true

require "async"
require "async/barrier"
require "async/semaphore"
require "async/http/internet"

module Finviz
  # Async way to fetch the data
  class Crawler
    class << self
      def call(*args)
        new(*args).tap(&:fetch).result
      end
    end

    def initialize(paths: [])
      @paths = Array(paths)
    end

    attr_reader :paths

    def fetch
      async do
        paths.each do |path|
          semaphore.async do
            response = internet.get(path.to_s, headers)
            result << OpenStruct.new(path: path, html: Nokogiri::HTML(response.read))
          end
        end
      end
    end

    def result
      @result ||= []
    end

    private

    def async
      Async do |task|
        # Spawn an asynchronous task for each topic:
        task.with_timeout(Finviz.config.timeout) do
          yield task

          # Ensure we wait for all requests to complete before continuing:
          barrier.wait
        end
      ensure
        internet&.close
      end
    end

    def internet
      @internet ||= Async::HTTP::Internet.new
    end

    def barrier
      @barrier ||= Async::Barrier.new
    end

    def semaphore
      @semaphore ||= Async::Semaphore.new(Finviz.config.concurrency, parent: barrier)
    end

    def headers
      [
        [
          "User-Agent",
          "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:#{rand(47..80)}.0) Gecko/20100101 Firefox/#{rand(47..80)}.0"
        ]
      ]
    end
  end
end
