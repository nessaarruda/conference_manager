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
      expect(page).to have_content("Organization: #{conference_1.organization}")
      expect(page).to have_content("Expected Attendance: #{conference_1.size}")
      expect(page).to have_content("Dates: #{conference_1.start_date} - #{conference_1.end_date}")
    end
  end
end
