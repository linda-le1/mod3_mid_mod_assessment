class SearchController < ApplicationController

    def index
        house = params[:house]

        conn = Faraday.new(url: "https://www.potterapi.com/") do |faraday|
            faraday.params['key'] = ENV["API_KEY"]
            faraday.adapter Faraday.default_adapter
        end

        response = conn.get("/v1/characters")
        json = JSON.parse(response.body, symbolize_names: true)

        @members = json.reduce([]) { |members, member|
            if member[:house] == params[:house] && member[:orderOfThePhoenix] == false
                members << member
            end
            members}

        @orderofthephoenix = json.reduce([]) { |members, member|
            if member[:house] == params[:house] && member[:orderOfThePhoenix] == true
                members << member
            end
            members}
    end
end
