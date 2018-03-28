require "httparty"
require 'uri'
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
            @top_champions = '/lol/champion-mastery/v3/champion-masteries/by-summoner/'
            @leagueVer = HTTParty.get('https://ddragon.leagueoflegends.com/api/versions.json').parsed_response[0]
        end
        
        
        def find(name)
            userPayload = HTTParty.get(URI.encode("#{@base_url}#{@profile_url}by-name/#{name}?api_key=#{@api_key}")).parsed_response
            user = {}
            userPayload.each{|k,v| user[k.to_sym] = v}
            return user
        end
        
        def rank_info(id)
            rankPayload = HTTParty.get("#{@base_url}#{@rank_url}#{id.to_i}?api_key=#{@api_key}").parsed_response
            rankInfo = {:solo => {}, :flex => {}, :tt => {}}
            rankPayload.each {|x|
                if x['queueType'].eql?"RANKED_SOLO_5x5"
                    x.each {|k,v|rankInfo[:solo][k.to_sym] = v}
                elsif x['queueType'].eql? "RANKED_FLEX_SR"
                    x.each {|k,v|rankInfo[:flex][k.to_sym] = v}
                    
                elsif x['queueType'].eql? "RANKED_TT_SR"
                    x.each {|k,v|rankInfo[:tt][k.to_sym] = v}
                end }
            return rankInfo
        end
        
        def icon(iconId)
            icon = "https://ddragon.leagueoflegends.com/cdn/#{@leagueVer}/img/profileicon/#{iconId.to_i}.png"
            return icon
        end
        
        def champion_mastery(id, count = 0)
            mastery = HTTParty.get("#{@base_url}#{@top_champions}#{id.to_i}?api_key=#{@api_key}").parsed_response
            topChamps = []
            if not count.to_i <= 0 or mastery.size == count.to_i
                (0...count.to_i).each {|x| topChamps.push(mastery[x])}
                return topChamps
            else
                return mastery
            end
            
        end
        
            
        def get_solo(id)
            rankPayload = HTTParty.get("#{@base_url}#{@rank_url}#{id.to_i}?api_key=#{@api_key}").parsed_response
            solo = {}
            @solo = nil
            rankPayload.each{|x| @solo = rankPayload.index(x) if x['queueType'].eql?'RANKED_SOLO_5x5'}
            if not @solo.nil?
                (rankPayload[@solo]).each {|k,v| solo[k.to_sym] = v if not "queueType".eql?k or "playerOrTeamName".eql?k or "playerOrTeamId".eql?k}
            end
            return solo
        end
        
        def get_flex(id)
            rank_payload = HTTParty.get("#{@base_url}#{@rank_url}#{id.to_i}?api_key=#{@api_key}").parsed_response
            flex = {}
            @flex = nil
            rank_payload.each{|x| @flex = rank_payload.index(x) if x['queueType'].eql?'RANKED_FLEX_SR'}
            if not @flex.nil?
                (rank_payload[@flex]).each {|k,v| flex[k.to_sym] = v if not "queueType".eql?k or "playerOrTeamName".eql?k or "playerOrTeamId".eql?k}
            end
            return flex
        end
        
        def get_tt(id)
            rankPayload = HTTParty.get("#{@base_url}#{@rank_url}#{id.to_i}?api_key=#{@api_key}").parsed_response
            tt = {}
            @tt = nil
            rankPayload.each{|x| @tt = rankPayload.index(x) if x['queueType'].eql?'RANKED_TT_SR'}
            if not @tt.nil?
                (rankPayload[@tt]).each {|k,v| tt[k.to_sym] = v if not "queueType".eql?k or "playerOrTeamName".eql?k or "playerOrTeamId".eql?k}
            end
            return tt
        end
        
    end
end
