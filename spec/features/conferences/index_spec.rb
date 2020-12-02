require 'rails_helper'

describe 'as a visitor' do
  describe 'conferences index page' do
    it "can see the name of each parent record in the system" do
      conference_1 = Conference.create(name: "World Ruby Conference",
                                      organization: "Ruby Association",
                                      size: 2000,
                                      start_date: "2021-01-19",
                                      end_date: "2021-01-21")
      conference_2 = Conference.create(name: "Creating Change",
                                      organization: "National LGBTQ Task Force",
                                      size: 6000,
                                      start_date: "2020-01-21",
                                      end_date: "2020-01-24")

      visit "/conferences"

      expect(page).to have_content("Conference List")
      expect(page).to have_content(conference_1.name)
      expect(page).to have_content("#{conference_1.start_date} - #{conference_1.end_date}")
      expect(page).to have_content(conference_2.name)
      expect(page).to have_content("#{conference_2.start_date} - #{conference_2.end_date}")
      expect(page).to have_link("New Conference", href: '/conferences/new')
    end
  end
end
