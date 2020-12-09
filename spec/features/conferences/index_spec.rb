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
      expect(page).to have_link(conference_1.name, href: "/conferences/#{conference_1.id}")
      expect(page).to have_link(conference_2.name, href: "/conferences/#{conference_2.id}")
    end

    it "has a link to create a new Conference record" do
      visit "/conferences"

      expect(page).to have_link("New Conference", href: '/conferences/new')
    end

    it "navigates to the /conferences page from the link to create a new conference" do
      visit "/conferences"

      click_link("New Conference")

      expect(page).to have_current_path('/conferences/new')
    end
  end
end
