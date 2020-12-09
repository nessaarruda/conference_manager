require 'rails_helper'

describe 'As a User' do
  describe 'When I visit /' do
    it 'Displays welcome message' do
    visit '/'

    expect(page).to have_content('Welcome to Conference Manager')
    expect(page).to have_link("Conferences")
    expect(page).to have_link("Meeting Rooms")
    expect(page).to have_link("Presentations")
    expect(page).to have_link("Meetings")
    end
  end

  describe 'site navigation' do
    it 'navigates to the conferences page' do
      visit '/'

      click_on("Conferences")

      expect(page).to have_current_path('/conferences')
    end

    it 'navigates to the meeting rooms page' do
      visit '/'

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    it 'navigates to the presentations page' do
      visit '/'

      click_on("Presentations")

      expect(page).to have_current_path('/presentations')
    end

    it 'navigates to the meetings page' do
      visit '/'

      click_on("Meetings")

      expect(page).to have_current_path('/meetings')
    end
  end
end
