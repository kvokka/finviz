[![CircleCI](https://circleci.com/gh/kvokka/finviz.svg?style=svg&circle-token=804e72e82fd4ccedc8f06cb332cc53d21e83535c)](https://circleci.com/gh/kvokka/finviz)
[![Gem Version](https://img.shields.io/gem/v/finviz.svg)](https://rubygems.org/gems/finviz)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

# Finviz

Unofficial finviz.com API

All requests are concurrent and lighting fast (using
[async-http](https://github.com/socketry/async-http) under the hood).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'finviz'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install finviz

## Usage

### Fetch tickers list from user filter

Since it is more convenient to use web based interface to set the filters, there
are 2 options to filter tickers.

```ruby
# with raw url
Finviz.tickers uri: 'https://finviz.com/screener.ashx?v=211&f=fa_pe_u5,sh_price_u3&ft=4'
=> ["BHAT", "CEPU", "CIH", "CMCM", "DLNG", "EDTK", "FENG", "JOB", "QD", "SND", "SUPV"]

# with manual filters cherry-picking
Finviz.tickers filters: %w[fa_pe_u5 sh_price_u3]
=> ["BHAT", "CEPU", "CIH", "CMCM", "DLNG", "EDTK", "FENG", "JOB", "QD", "SND", "SUPV"]
```

### Fetch quotes

Each quote contain the OpenStruct with ticker stats and links to the ticker and chart, see
example:

```ruby
[1] pry(main)> quotes = Finviz.quotes tickers: %w[aapl mrna]

[2] pry(main)> quotes.m # If the quote was not requested
=> nil

[3] pry(main)> quotes.aapl
=> #<Finviz::Quote:0x00007fb7189895f0
 @stats=
  {"Index"=>"DJIA S&P500",
   "P/E"=>"28.02",
   "EPS (ttm)"=>"4.46",
   "Insider Own"=>"0.07%",
   "Shs Outstand"=>"16.75B",
   "Perf Week"=>"-0.84%",
   "Market Cap"=>"2042.91B",
   "Forward P/E"=>"23.38",
   "EPS next Y"=>"2.89%",
   "Insider Trans"=>"-2.80%",
   "Shs Float"=>"16.68B",
   "Perf Month"=>"-7.41%",
   "Income"=>"76.31B",
   "PEG"=>"1.56",
   "EPS next Q"=>"0.99",
   "Inst Own"=>"59.90%",
   "Short Float"=>"0.50%",
   "Perf Quarter"=>"-4.58%",
   "Sales"=>"325.41B",
   "P/S"=>"6.28",
   "EPS this Y"=>"10.20%",
   "Inst Trans"=>"-0.49%",
   "Short Ratio"=>"0.79",
   "Perf Half Y"=>"4.69%",
   "Book/sh"=>"4.13",
   "P/B"=>"30.23",
   "ROA"=>"22.90%",
   "Target Price"=>"159.74",
   "Perf Year"=>"58.56%",
   "Cash/sh"=>"4.27",
   "P/C"=>"29.25",
   "EPS next 5Y"=>"17.93%",
   "ROE"=>"111.80%",
   "52W Range"=>"77.58 - 145.09",
   "Perf YTD"=>"-5.91%",
   "Dividend"=>"0.88",
   "P/FCF"=>"26.79",
   "EPS past 5Y"=>"7.30%",
   "ROI"=>"31.70%",
   "52W High"=>"-13.95%",
   "Beta"=>"1.22",
   "Dividend %"=>"0.70%",
   "Quick Ratio"=>"1.10",
   "Sales past 5Y"=>"3.30%",
   "Gross Margin"=>"39.90%",
   "52W Low"=>"60.93%",
   "ATR"=>"2.90",
   "Employees"=>"147000",
   "Current Ratio"=>"1.10",
   "Sales Q/Q"=>"53.60%",
   "Oper. Margin"=>"27.30%",
   "RSI (14)"=>"41.95",
   "Volatility"=>"1.65% 2.00%",
   "Optionable"=>"Yes",
   "Debt/Eq"=>"1.76",
   "EPS Q/Q"=>"118.60%",
   "Profit Margin"=>"23.50%",
   "Rel Volume"=>"0.60",
   "Prev Close"=>"126.27",
   "Shortable"=>"Yes",
   "LT Debt/Eq"=>"1.57",
   "Earnings"=>"Apr 28 AMC",
   "Payout"=>"18.20%",
   "Avg Volume"=>"104.09M",
   "Price"=>"124.85",
   "Recom"=>"2.00",
   "SMA20"=>"-4.08%",
   "SMA50"=>"-1.80%",
   "SMA200"=>"1.15%",
   "Volume"=>"62,545,117",
   "Change"=>"-1.12%"},
 @ticker="aapl">

[4] pry(main)> quotes.aapl.chart
=> "https://charts2.finviz.com/chart.ashx?t=aapl&ty=c&ta=1&p=d&s=l"

[5] pry(main)> quotes.aapl.path
=> "https://finviz.com/quote.ashx?t=aapl"

[6] pry(main)> quotes.aapl.to_h
=> {:stats=>
  {"Index"=>"DJIA S&P500",
   "P/E"=>"28.02",
   "EPS (ttm)"=>"4.46",
   "Insider Own"=>"0.07%",
   "Shs Outstand"=>"16.75B",
   "Perf Week"=>"-0.84%",
   "Market Cap"=>"2042.91B",
   "Forward P/E"=>"23.38",
   "EPS next Y"=>"2.89%",
   "Insider Trans"=>"-2.80%",
   "Shs Float"=>"16.68B",
   "Perf Month"=>"-7.41%",
   "Income"=>"76.31B",
   "PEG"=>"1.56",
   "EPS next Q"=>"0.99",
   "Inst Own"=>"59.90%",
   "Short Float"=>"0.50%",
   "Perf Quarter"=>"-4.58%",
   "Sales"=>"325.41B",
   "P/S"=>"6.28",
   "EPS this Y"=>"10.20%",
   "Inst Trans"=>"-0.49%",
   "Short Ratio"=>"0.79",
   "Perf Half Y"=>"4.69%",
   "Book/sh"=>"4.13",
   "P/B"=>"30.23",
   "ROA"=>"22.90%",
   "Target Price"=>"159.74",
   "Perf Year"=>"58.56%",
   "Cash/sh"=>"4.27",
   "P/C"=>"29.25",
   "EPS next 5Y"=>"17.93%",
   "ROE"=>"111.80%",
   "52W Range"=>"77.58 - 145.09",
   "Perf YTD"=>"-5.91%",
   "Dividend"=>"0.88",
   "P/FCF"=>"26.79",
   "EPS past 5Y"=>"7.30%",
   "ROI"=>"31.70%",
   "52W High"=>"-13.95%",
   "Beta"=>"1.22",
   "Dividend %"=>"0.70%",
   "Quick Ratio"=>"1.10",
   "Sales past 5Y"=>"3.30%",
   "Gross Margin"=>"39.90%",
   "52W Low"=>"60.93%",
   "ATR"=>"2.90",
   "Employees"=>"147000",
   "Current Ratio"=>"1.10",
   "Sales Q/Q"=>"53.60%",
   "Oper. Margin"=>"27.30%",
   "RSI (14)"=>"41.95",
   "Volatility"=>"1.65% 2.00%",
   "Optionable"=>"Yes",
   "Debt/Eq"=>"1.76",
   "EPS Q/Q"=>"118.60%",
   "Profit Margin"=>"23.50%",
   "Rel Volume"=>"0.60",
   "Prev Close"=>"126.27",
   "Shortable"=>"Yes",
   "LT Debt/Eq"=>"1.57",
   "Earnings"=>"Apr 28 AMC",
   "Payout"=>"18.20%",
   "Avg Volume"=>"104.09M",
   "Price"=>"124.85",
   "Recom"=>"2.00",
   "SMA20"=>"-4.08%",
   "SMA50"=>"-1.80%",
   "SMA200"=>"1.15%",
   "Volume"=>"62,545,117",
   "Change"=>"-1.12%"},
 :path=>"https://finviz.com/quote.ashx?t=aapl",
 :chart=>"https://charts2.finviz.com/chart.ashx?t=aapl&ty=c&ta=1&p=d&s=l",
 :ticker=>"aapl"}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kvokka/finviz. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/kvokka/finviz/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Finviz project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kvokka/finviz/blob/master/CODE_OF_CONDUCT.md).
