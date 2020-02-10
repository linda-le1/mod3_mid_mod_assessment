class SearchController < ApplicationController

    def index
        house = params[:house]

        conn = Faraday.new(url: "https://www.potterapi.com/") do |faraday|
            faraday.params['key'] = ENV["API_KEY"]
            faraday.adapter Faraday.default_adapter
        end

        response = conn.get("/v1/houses/5a05e2b252f721a3cf2ea33f")
        json = JSON.parse(response.body, symbolize_names: true)
        @members = json.first[:members]
    end

end
