require_relative('challenger')
require_relative('summoner')
module RubyGg
    
    class Client
        attr_reader :api_key
        attr_accessor :region
        attr_reader :base_url
        def initialize(api_key, region = 'na')
            @api_key = api_key
            @region = region
            @base_url = "https://#{@region}1.api.riotgames.com"
        end
    
        def challenger
            @challenger = Challenger.new(api_key, region)
        end
        
        def summoner
            @summoner = Summoner.new(api_key, region)
        end
    
    end

end