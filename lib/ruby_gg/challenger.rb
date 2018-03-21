require "httparty"

module RubyGg
    
    class Challenger
        attr_reader :challenger_url
        
        def initialize(api_key, region)
            @api_key = api_key
            @region = region
            @base_url = "https://#{@region}1.api.riotgames.com"
            @challenger_url = "/lol/league/v3/challengerleagues/by-queue/"
        end
        
        def solo_challengers #returns ID of top 5 solo/duo challenger players of the region.
            queue = 'RANKED_SOLO_5x5'
            final_url = "#{@base_url}#{@challenger_url}#{queue}?api_key=#{@api_key}"
            payload = HTTParty.get(final_url)
            challengers = payload['entries']
            challengers.sort!{|x, y| y['leaguePoints'] <=> x['leaguePoints']}
            id = []
            (0...5).each{|n| id.push(challengers[n]['playerOrTeamId'])}
            return id
        end
        
        
    end
end
