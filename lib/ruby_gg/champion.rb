require "httparty"

module RubyGg
    
    class Champion
        attr_reader :champion_url
        
        def initialize(api_key, region) #Initializing the Challenger Instance. 
            @api_key = api_key
            @region = region
            @base_url = "https://#{@region}.api.riotgames.com"
            @champion_url = "/lol/league/v3/challengerleagues/by-queue/"
        end
        
    end
    
end