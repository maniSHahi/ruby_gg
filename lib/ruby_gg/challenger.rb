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
            if size.to_i == 0 || size.to_i >200
                size = paycheck.size
            else
                size = size.to_i
            end
            paycheck = (HTTParty.get("#{@base_url}#{@challenger_url}RANKED_SOLO_5x5?api_key=#{@api_key}").parsed_response)['entries']
            payload = []
            paycheck.sort!{|x, y| y['leaguePoints'] <=> x['leaguePoints']}
            (0...size).each {|x| payload.push(player_dto(paycheck[x]))}
            return payload
        end
        
        private
        def player_dto(player)
            dto = {}
            player.each{|k,v| dto[k.to_sym] = v }
            return dto
        end
    end
end
