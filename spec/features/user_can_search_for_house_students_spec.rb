require 'rails_helper'

feature 'user can search for house members' do
    scenario 'when submitting a valid house name' do

        visit '/'

        select "Gryffindor", from: :house
        click_on "Search For Members"

        expect(current_path).to eq(search_path)

        expect(page).to have_content("21 Members of Gryffindor")

        expect(page).to have_css(".member", count: 21)

        within(first(".member")) do
            expect(page).to have_css('.name')
            expect(page).to have_css('.role')
            expect(page).to have_css('.house')
            expect(page).to have_css('.Patronus')
    end
end


