require 'rails_helper'

describe 'as a visitor' do
  describe 'new meeting_room record page' do
    it 'displays a form for creating a new meeting_room record' do
      visit '/meeting_rooms/new'

      expect(page).to have_content("New Meeting Room")
      expect(page).to have_selector('form')
      expect(page).to have_field('metname', type: 'text')
      expect(page).to have_text('Capacity:')
      expect(page).to have_field('capacity', type: 'bigint')
    end

    it 'has a button to Create Meeting Room' do
      visit '/meeting_rooms/new'

      expect(page).to have_button('Create Meeting Room', type: 'submit')
    end

    it 'creates a new meeting_room and redirects to the meeting_rooms index' do
      visit '/meeting_rooms/new'

      fill_in('metname', with: 'Oprah')
      fill_in('capacity', with: 30)
      click_on('Create Meeting Room')

      expect(page).to have_current_path('/meeting_rooms')
    end
  end
end
