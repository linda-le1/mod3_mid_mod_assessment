class PotterApiService
    def members_by_house(house)
        conn = Faraday.new(url: "https://www.potterapi.com/") do |faraday|
            faraday.params['key'] = ENV["API_KEY"]
            faraday.adapter Faraday.default_adapter
        end
        response = conn.get("/v1/characters")
        json = JSON.parse(response.body, symbolize_names: true)

        @orderofthephoenix = json.map do|member_info|
            if member_info[:house] == house && member_info[:orderOfThePhoenix] == true
                Member.new(member_info)
            end
        end
    end
end