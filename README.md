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

Each quote contain the Hash with ticker stats and link to the chart picture, see
example:

```ruby
quotes = Finviz.quotes tickers: %w[a c]
=> [#<OpenStruct ticker="A", chart="https://charts2.finviz.com/chart.ashx?t=C&ty=c&ta=1&p=d&s=l", stats={"Index"=>"S&P 500", "P/E"=>"50.35", "EPS (ttm)"=>"2.60", "Insider Own"=>"0.30%", "Shs Outstand"=>"306.00M", "Perf Week"=>"-2.05%", "Market Cap"=>"39.62B", "Forward P/E"=>"30.11", "EPS next Y"=>"11.78%", "Insider Trans"=>"-21.60%", "Shs Float"=>"303.84M", "Perf Month"=>"-1.60%", "Income"=>"810.00M", "PEG"=>"4.66", "EPS next Q"=>"0.83", "Inst Own"=>"91.60%", "Short Float"=>"0.70%", "Perf Quarter"=>"2.48%", "Sales"=>"5.53B", "P/S"=>"7.16", "EPS this Y"=>"-31.60%", "Inst Trans"=>"0.76%", "Short Ratio"=>"1.31", "Perf Half Y"=>"19.87%", "Book/sh"=>"15.70", "P/B"=>"8.35", "ROA"=>"8.50%", "Target Price"=>"140.23", "Perf Year"=>"60.64%", "Cash/sh"=>"4.40", "P/C"=>"29.81", "EPS next 5Y"=>"10.80%", "ROE"=>"16.70%", "52W Range"=>"80.46 - 137.83", "Perf YTD"=>"10.68%", "Dividend"=>"0.78", "P/FCF"=>"45.69", "EPS past 5Y"=>"12.00%", "ROI"=>"10.00%", "52W High"=>"-5.31%", "Beta"=>"1.01", "Dividend %"=>"0.59%", "Quick Ratio"=>"1.60", "Sales past 5Y"=>"5.70%", "Gross Margin"=>"53.30%", "52W Low"=>"62.21%", "ATR"=>"2.09", "Employees"=>"16400", "Current Ratio"=>"2.10", "Sales Q/Q"=>"14.10%", "Oper. Margin"=>"17.30%", "RSI (14)"=>"47.33", "Volatility"=>"1.56% 1.40%", "Optionable"=>"Yes", "Debt/Eq"=>"0.52", "EPS Q/Q"=>"48.10%", "Profit Margin"=>"14.60%", "Rel Volume"=>"0.32", "Prev Close"=>"131.15", "Shortable"=>"Yes", "LT Debt/Eq"=>"0.45", "Earnings"=>"May 25 AMC", "Payout"=>"27.40%", "Avg Volume"=>"1.63M", "Price"=>"130.51", "Recom"=>"1.90", "SMA20"=>"-2.03%", "SMA50"=>"1.48%", "SMA200"=>"13.20%", "Volume"=>"291,826", "Change"=>"-0.48%"}>, #<OpenStruct ticker="C", chart="https://charts2.finviz.com/chart.ashx?t=C&ty=c&ta=1&p=d&s=l", stats={"Index"=>"S&P 500", "P/E"=>"10.50", "EPS (ttm)"=>"7.29", "Insider Own"=>"0.20%", "Shs Outstand"=>"2.08B", "Perf Week"=>"1.97%", "Market Cap"=>"155.63B", "Forward P/E"=>"9.32", "EPS next Y"=>"-8.81%", "Insider Trans"=>"-1.30%", "Shs Float"=>"2.04B", "Perf Month"=>"5.54%", "Income"=>"15.26B", "PEG"=>"0.96", "EPS next Q"=>"2.00", "Inst Own"=>"78.80%", "Short Float"=>"1.20%", "Perf Quarter"=>"20.32%", "Sales"=>"53.48B", "P/S"=>"2.91", "EPS this Y"=>"-41.10%", "Inst Trans"=>"0.52%", "Short Ratio"=>"1.27", "Perf Half Y"=>"56.47%", "Book/sh"=>"87.55", "P/B"=>"0.87", "ROA"=>"0.70%", "Target Price"=>"85.23", "Perf Year"=>"82.03%", "Cash/sh"=>"486.62", "P/C"=>"0.16", "EPS next 5Y"=>"10.91%", "ROE"=>"8.60%", "52W Range"=>"40.49 - 76.84", "Perf YTD"=>"24.16%", "Dividend"=>"2.04", "P/FCF"=>"7.76", "EPS past 5Y"=>"-2.70%", "ROI"=>"6.80%", "52W High"=>"0.38%", "Beta"=>"1.90", "Dividend %"=>"2.66%", "Quick Ratio"=>"-", "Sales past 5Y"=>"-0.20%", "Gross Margin"=>"-", "52W Low"=>"90.49%", "ATR"=>"1.72", "Employees"=>"211000", "Current Ratio"=>"-", "Sales Q/Q"=>"-26.90%", "Oper. Margin"=>"64.00%", "RSI (14)"=>"67.16", "Volatility"=>"2.44% 2.21%", "Optionable"=>"Yes", "Debt/Eq"=>"2.70", "EPS Q/Q"=>"240.40%", "Profit Margin"=>"28.50%", "Rel Volume"=>"0.75", "Prev Close"=>"76.56", "Shortable"=>"Yes", "LT Debt/Eq"=>"1.35", "Earnings"=>"Apr 15 BMO", "Payout"=>"27.80%", "Avg Volume"=>"19.41M", "Price"=>"77.13", "Recom"=>"2.10", "SMA20"=>"5.61%", "SMA50"=>"6.01%", "SMA200"=>"31.30%", "Volume"=>"8,126,075", "Change"=>"0.74%"}>]

# The same in more human friendly view:
Pry::ColorPrinter.pp(quotes.map(&:to_h))
=> [{:ticker=>"A",
  :chart=>"https://charts2.finviz.com/chart.ashx?t=C&ty=c&ta=1&p=d&s=l",
  :stats=>
   {"Index"=>"S&P 500",
    "P/E"=>"50.35",
    "EPS (ttm)"=>"2.60",
    "Insider Own"=>"0.30%",
    "Shs Outstand"=>"306.00M",
    "Perf Week"=>"-2.05%",
    "Market Cap"=>"39.62B",
    "Forward P/E"=>"30.11",
    "EPS next Y"=>"11.78%",
    "Insider Trans"=>"-21.60%",
    "Shs Float"=>"303.84M",
    "Perf Month"=>"-1.60%",
    "Income"=>"810.00M",
    "PEG"=>"4.66",
    "EPS next Q"=>"0.83",
    "Inst Own"=>"91.60%",
    "Short Float"=>"0.70%",
    "Perf Quarter"=>"2.48%",
    "Sales"=>"5.53B",
    "P/S"=>"7.16",
    "EPS this Y"=>"-31.60%",
    "Inst Trans"=>"0.76%",
    "Short Ratio"=>"1.31",
    "Perf Half Y"=>"19.87%",
    "Book/sh"=>"15.70",
    "P/B"=>"8.35",
    "ROA"=>"8.50%",
    "Target Price"=>"140.23",
    "Perf Year"=>"60.64%",
    "Cash/sh"=>"4.40",
    "P/C"=>"29.81",
    "EPS next 5Y"=>"10.80%",
    "ROE"=>"16.70%",
    "52W Range"=>"80.46 - 137.83",
    "Perf YTD"=>"10.68%",
    "Dividend"=>"0.78",
    "P/FCF"=>"45.69",
    "EPS past 5Y"=>"12.00%",
    "ROI"=>"10.00%",
    "52W High"=>"-5.31%",
    "Beta"=>"1.01",
    "Dividend %"=>"0.59%",
    "Quick Ratio"=>"1.60",
    "Sales past 5Y"=>"5.70%",
    "Gross Margin"=>"53.30%",
    "52W Low"=>"62.21%",
    "ATR"=>"2.09",
    "Employees"=>"16400",
    "Current Ratio"=>"2.10",
    "Sales Q/Q"=>"14.10%",
    "Oper. Margin"=>"17.30%",
    "RSI (14)"=>"47.33",
    "Volatility"=>"1.56% 1.40%",
    "Optionable"=>"Yes",
    "Debt/Eq"=>"0.52",
    "EPS Q/Q"=>"48.10%",
    "Profit Margin"=>"14.60%",
    "Rel Volume"=>"0.32",
    "Prev Close"=>"131.15",
    "Shortable"=>"Yes",
    "LT Debt/Eq"=>"0.45",
    "Earnings"=>"May 25 AMC",
    "Payout"=>"27.40%",
    "Avg Volume"=>"1.63M",
    "Price"=>"130.51",
    "Recom"=>"1.90",
    "SMA20"=>"-2.03%",
    "SMA50"=>"1.48%",
    "SMA200"=>"13.20%",
    "Volume"=>"291,826",
    "Change"=>"-0.48%"}},
 {:ticker=>"C",
  :chart=>"https://charts2.finviz.com/chart.ashx?t=C&ty=c&ta=1&p=d&s=l",
  :stats=>
   {"Index"=>"S&P 500",
    "P/E"=>"10.50",
    "EPS (ttm)"=>"7.29",
    "Insider Own"=>"0.20%",
    "Shs Outstand"=>"2.08B",
    "Perf Week"=>"1.97%",
    "Market Cap"=>"155.63B",
    "Forward P/E"=>"9.32",
    "EPS next Y"=>"-8.81%",
    "Insider Trans"=>"-1.30%",
    "Shs Float"=>"2.04B",
    "Perf Month"=>"5.54%",
    "Income"=>"15.26B",
    "PEG"=>"0.96",
    "EPS next Q"=>"2.00",
    "Inst Own"=>"78.80%",
    "Short Float"=>"1.20%",
    "Perf Quarter"=>"20.32%",
    "Sales"=>"53.48B",
    "P/S"=>"2.91",
    "EPS this Y"=>"-41.10%",
    "Inst Trans"=>"0.52%",
    "Short Ratio"=>"1.27",
    "Perf Half Y"=>"56.47%",
    "Book/sh"=>"87.55",
    "P/B"=>"0.87",
    "ROA"=>"0.70%",
    "Target Price"=>"85.23",
    "Perf Year"=>"82.03%",
    "Cash/sh"=>"486.62",
    "P/C"=>"0.16",
    "EPS next 5Y"=>"10.91%",
    "ROE"=>"8.60%",
    "52W Range"=>"40.49 - 76.84",
    "Perf YTD"=>"24.16%",
    "Dividend"=>"2.04",
    "P/FCF"=>"7.76",
    "EPS past 5Y"=>"-2.70%",
    "ROI"=>"6.80%",
    "52W High"=>"0.38%",
    "Beta"=>"1.90",
    "Dividend %"=>"2.66%",
    "Quick Ratio"=>"-",
    "Sales past 5Y"=>"-0.20%",
    "Gross Margin"=>"-",
    "52W Low"=>"90.49%",
    "ATR"=>"1.72",
    "Employees"=>"211000",
    "Current Ratio"=>"-",
    "Sales Q/Q"=>"-26.90%",
    "Oper. Margin"=>"64.00%",
    "RSI (14)"=>"67.16",
    "Volatility"=>"2.44% 2.21%",
    "Optionable"=>"Yes",
    "Debt/Eq"=>"2.70",
    "EPS Q/Q"=>"240.40%",
    "Profit Margin"=>"28.50%",
    "Rel Volume"=>"0.75",
    "Prev Close"=>"76.56",
    "Shortable"=>"Yes",
    "LT Debt/Eq"=>"1.35",
    "Earnings"=>"Apr 15 BMO",
    "Payout"=>"27.80%",
    "Avg Volume"=>"19.41M",
    "Price"=>"77.13",
    "Recom"=>"2.10",
    "SMA20"=>"5.61%",
    "SMA50"=>"6.01%",
    "SMA200"=>"31.30%",
    "Volume"=>"8,126,075",
    "Change"=>"0.74%"}}]
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
