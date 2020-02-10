class MemberSearch
    attr_reader :house

    def initialize(house)
        @house = house
    end

    def order_of_phoenix_members
        conn = Faraday.new(url: "https://www.potterapi.com/") do |faraday|
            faraday.params['key'] = ENV["API_KEY"]
            faraday.adapter Faraday.default_adapter
        end

        response = conn.get("/v1/characters")
        json = JSON.parse(response.body, symbolize_names: true)

        order_of_phoenix_members(house).map do|member_info|
            if member_info[:house] == house && member_info[:orderOfThePhoenix] == true
                Member.new(member_info)
            end
        end
    end

    def count
        order_of_phoenix_members.count
    end
end