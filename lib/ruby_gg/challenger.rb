require "httparty"

module RubyGg
    
    class Challenger
        attr_reader :challenger_url
        
        def initialize(api_key, region) #Initializing the Challenger Instance. 
            @api_key = api_key
            @region = region
            @base_url = "https://#{@region}.api.riotgames.com"
            @challenger_url = "/lol/league/v3/challengerleagues/by-queue/"
        end
        
        def solo_queue (size = 0) # Not passing an argument / passing string (unless string is number)/ 0 => returns all 200 results.
            payCheck = (HTTParty.get("#{@base_url}#{@challenger_url}RANKED_SOLO_5x5?api_key=#{@api_key}").parsed_response)['entries']
            if size.to_i == 0 || size.to_i >200
                size = payCheck.size
            else
                size = size.to_i
            end
            payLoad = []
            payCheck.sort!{|x, y| y['leaguePoints'] <=> x['leaguePoints']}
            (0...size).each {|x| payLoad.push(player_dto(payCheck[x]))}
            return payLoad
        end
        
        private
        def player_dto(player)
            dto = {}
            player.each{|k,v| dto[k.to_sym] = v }
            return dto
        end
    end
end
