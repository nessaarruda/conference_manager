require 'rails_helper'

describe 'as a visitor' do
  describe 'show conference page' do
    it 'displays the conference with that id and its attributes' do
      conference_1 = Conference.create(name: "World Ruby Conference",
                                      organization: "Ruby Association",
                                      size: 2000,
                                      start_date: "2021-01-19",
                                      end_date: "2021-01-21")

      visit "/conferences/#{conference_1.id}"

      expect(page).to have_content(conference_1.name)
      expect(page).to have_content("#{conference_1.organization}")
      expect(page).to have_content("Expected Attendance: #{conference_1.size}")
      expect(page).to have_content("#{conference_1.start} to #{conference_1.end}")
    end

    it 'has a link to update the conference' do
      conference_1 = Conference.create(name: "World Ruby Conference",
                                      organization: "Ruby Association",
                                      size: 2000,
                                      start_date: "2021-01-19",
                                      end_date: "2021-01-21")

      visit "/conferences/#{conference_1.id}"

      expect(page).to have_link("Update Conference", href: "/conferences/#{conference_1.id}/edit")

      click_link("Update Conference")

      expect(page).to have_current_path("/conferences/#{conference_1.id}/edit")
    end
  end
end
