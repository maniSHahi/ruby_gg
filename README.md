# RubyGg

RubyGg is a league api wrapper gem that handles the API end points of the league of legends.

It is programmed to wrap the API END POINTS in trouble-free manner to get the data from league api. 


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_gg'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_gg

## Usage

Create new instace of the Client:
    # Where api_key is your league api key and region is the region your summoner is located at (Defaults to na if not provided).
    client = RubyGg::Client.new(api_key, region)
    
Get SummonerID of top 5 challenger players of the declared region:
    topFiveChallenger = client.challenger.solo_chanllengers

Get SummonerInfo(IGN, TIER, RANK, LP, WINS, LOSS, ICON, LEVEL)
    # Where ID can be passed as integer or string.
    summonerInfo = client.summoner.get_profile(id)
    
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/maniSHahi/ruby_gg. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RubyGg project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ruby_gg/blob/master/CODE_OF_CONDUCT.md).
