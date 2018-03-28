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
```ruby
    client = RubyGg::Client.new(api_key, region)  
    # api_key is your league_api_key and region is the region you want.
```
Gets list of challenger players
By default paramater passed in is zero (which returns back all 200 challengers).
However you can pass in interger or string of an integer to get set number of results (1-200 or it'll return all 200).
```ruby
    client.challenger.solo_queue(100) # This returns 100 challenger players.
    client.challenger.solo_queue('100') # This does same thing.
    client.challenger.solo_queue # This returns all 200.
    client.challenger.solo_queue(iamidiot) # This will still return all 200.
```    
Gets summoners information (for data types check league api documentation). returnType is hashValue.
returnType = {:user => {userDto}, :solo => {soloDto}, :flex => {flexDto}, :tt => {ttDto}}
```ruby
    client.summoner.get_user(id) #Where id can be int or str. 
    You can check for id from client.challenger.solo_queue()[0][:playerOrTeamId] # Gives the id for first challenger player in the list returned.
```
Gets summoners Champion Masteries (returns hashValue).
returnType = [{"playerId"=>72859900, "championId"=>53, "championLevel"=>1, "championPoints"=>124, "lastPlayTime"=>1475296559000, "championPointsSinceLastLevel"=>124, "championPointsUntilNextLevel"=>1676, "chestGranted"=>false, "tokensEarned"=>0}]

```ruby
    client.summoner.champion_mastery(id, count) # where id and count both can be str or int. Id is summoner's ID, and count is number of data you want back (it is sorted according to most mastery points).
    client.summoner.champion_mastery(id, 3) # returns 3 top mastery points champs.
    You can check for id from client.challenger.solo_queue()[0][:playerOrTeamId] # Gives the id for first challenger player in the list returned.
```
Gets champions name with their id.

```ruby
    client.champion.get_name(championId) # Champion Id can be str or int. 
    # You can get the championId from client.summoner.champion_mastery(id, count) ==> for count == 1 [0][championId] will return championId.
    Example:
    masteries = client.summoner.champion_mastery(72859900, 3) # That will return 3 top champion_mastery for that id *Rockerturner is the username*.
    topChamp = []
    masteries.each{|x| topChamp.push(x['championId'])} 
    
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/maniSHahi/ruby_gg. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RubyGg project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ruby_gg/blob/master/CODE_OF_CONDUCT.md).
