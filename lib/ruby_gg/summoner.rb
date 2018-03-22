require "httparty"

module RubyGg
    
    class Summoner
        attr_reader :rank_url
        attr_reader :profile_url
        
        def initialize(api_key, region)
            @api_key = api_key
            @region = region
            @base_url = "https://#{@region}.api.riotgames.com"
            @rank_url = '/lol/league/v3/positions/by-summoner/'
            @profile_url = '/lol/summoner/v3/summoners/'
        end
        
        def get_profile(id)
            summoner_info = {}
            summoner_info[:user] = get_user(id)
            summoner_info[:solo] = get_solo(id)
            summoner_info[:flex] = get_flex(id)
            summoner_info[:tt] = get_tt(id)
            return summoner_info
        end
        
        private
        def get_user(id)
            user_payload = HTTParty.get("#{@base_url}#{@profile_url}#{id.to_i}?api_key=#{@api_key}").parsed_response
            user = {}
            user_payload.each{|k,v| user[k.to_sym] = v}
            return user
        end
            
        private
        def get_solo(id)
            rank_payload = HTTParty.get("#{@base_url}#{@rank_url}#{id.to_i}?api_key=#{@api_key}").parsed_response
            solo = {}
            @solo = nil
            rank_payload.each{|x| @solo = rank_payload.index(x) if x['queueType'].eql?'RANKED_SOLO_5x5'}
            if not @solo.nil?
                (rank_payload[@solo]).each {|k,v| solo[k.to_sym] = v if not "queueType".eql?k or "playerOrTeamName".eql?k or "playerOrTeamId".eql?k}
            end
            return solo
        end
        
        private
        def get_flex(id)
            rank_payload = HTTParty.get("#{@base_url}#{@rank_url}#{id.to_i}?api_key=#{@api_key}").parsed_response
            flex = {}
            @flex = nil
            rank_payload.each{|x| @solo = rank_payload.index(x) if x['queueType'].eql?'RANKED_FLEX_SR'}
            if not @flex.nil?
                (rank_payload[@flex]).each {|k,v| flex[k.to_sym] = v if not "queueType".eql?k or "playerOrTeamName".eql?k or "playerOrTeamId".eql?k}
            end
            return flex
        end
        
        private
        def get_tt(id)
            rank_payload = HTTParty.get("#{@base_url}#{@rank_url}#{id.to_i}?api_key=#{@api_key}").parsed_response
            tt = {}
            @tt = nil
            rank_payload.each{|x| @tt = rank_payload.index(x) if x['queueType'].eql?'RANKED_TT_SR'}
            if not @tt.nil?
                (rank_payload[@tt]).each {|k,v| tt[k.to_sym] = v if not "queueType".eql?k or "playerOrTeamName".eql?k or "playerOrTeamId".eql?k}
            end
            return tt
        end
        
    end
end
