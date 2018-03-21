require "httparty"

module RubyGg
    
    class Summoner
        attr_reader :rank_url
        attr_reader :profile_url
        
        def initialize(api_key, region)
            @api_key = api_key
            @region = region
            @base_url = "https://#{@region}1.api.riotgames.com"
            @rank_url = '/lol/league/v3/positions/by-summoner/'
            @profile_url = '/lol/summoner/v3/summoners/'
        end
        
        def get_profile(id)
            id.to_i
            rank_url = "#{@base_url}#{@rank_url}#{id}?api_key=#{@api_key}"
            profile_url = "#{@base_url}#{@profile_url}#{id}?api_key=#{@api_key}"
            rank_payload = HTTParty.get(rank_url).parsed_response
            rank_payload.each {|x| @idx = rank_payload.index(x) if x['queueType'].eql?'RANKED_SOLO_5x5'}
            profile_payload = HTTParty.get(profile_url).parsed_response
            summoner_info = {}
            summoner_info[:ign] = rank_payload[@idx]['playerOrTeamName']
            summoner_info[:tier]= rank_payload[@idx]['tier']
            summoner_info[:rank]= rank_payload[@idx]['rank']
            summoner_info[:lp] = rank_payload[@idx]['leaguePoints']
            summoner_info[:wins] = rank_payload[@idx]['wins']
            summoner_info[:loss] = rank_payload[@idx]['losses']
            summoner_info[:icon] = profile_payload['profileIconId']
            summoner_info[:level] = profile_payload['summonerLevel']
            return summoner_info
        end
        
        
    end
end
