require_relative('challenger')
require_relative('summoner')
require_relative('champion')
module RubyGg
    
    class Client
        attr_reader :api_key
        attr_accessor :region
        attr_reader :base_url
        def initialize(api_key, region = 'na')
            @api_key = api_key
            region_tag = { :na => 'na1', 
                            :eune => 'eun1', 
                            :euw => 'euw1',
                            :jp => 'jp1',
                            :kr => 'kr',
                            :lan => 'la1',
                            :las => 'la2',
                            :br => 'br1',
                            :oce => 'oc1',
                            :tr => 'tr1',
                            :ru => 'ru',
                            :pbe => 'pbe1' }
            @region = region_tag[region.to_sym]
            @base_url = "https://#{@region}.api.riotgames.com"
        end
    
        def challenger
            @challenger = Challenger.new(@api_key, @region)
        end
        
        def summoner
            @summoner = Summoner.new(@api_key, @region)
        end
    
        def champion
            @champion = Champion.new(@api_key, @region)
        end
    end

end