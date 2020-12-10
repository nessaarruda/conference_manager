require 'rails_helper'

describe 'as a visitor' do
  describe 'new meeting_room record page' do
    it 'displays a form for creating a new meeting_room record' do
      visit '/meeting_rooms/new'

      expect(page).to have_content("New Meeting Room")
      expect(page).to have_selector('form')
      expect(page).to have_field(:name)
      expect(page).to have_text('Capacity')
      expect(page).to have_field('capacity')
    end

    it 'has a button to Create Meeting Room' do
      visit '/meeting_rooms/new'

      expect(page).to have_button('Create Meeting Room', type: 'submit')
    end

    it 'creates a new meeting_room and redirects to the meeting_rooms index' do
      visit '/meeting_rooms/new'

      fill_in(:name, with: 'Oprah')
      fill_in('Capacity', with: 30)
      click_on('Create Meeting Room')

      expect(page).to have_current_path('/meeting_rooms')
    end
    describe 'site navigation' do
      it 'has a navigation bar with links to other index pages' do
        visit "/meeting_rooms/new"

        expect(page).to have_link("Conference Manager Home")
        expect(page).to have_link("Meeting Rooms")
        expect(page).to have_link("Conferences")
        expect(page).to have_link("Presentations")
        expect(page).to have_link("Meetings")
      end

      it 'navigates to the welcome page' do
        visit "/meeting_rooms/new"

        click_on("Conference Manager Home")

        expect(page).to have_current_path('/')
      end

      it 'navigates to the meeting_rooms page' do
        visit "/meeting_rooms/new"

        click_on("Meeting Rooms")

        expect(page).to have_current_path('/meeting_rooms')
      end

      it 'navigates to the meeting rooms page' do
        visit "/meeting_rooms/new"

        click_on("Meeting Rooms")

        expect(page).to have_current_path('/meeting_rooms')
      end

      it 'navigates to the presentations page' do
        visit "/meeting_rooms/new"

        click_on("Meetings")

        expect(page).to have_current_path('/meetings')
      end

      it 'navigates to the meetings page' do
        visit "/meeting_rooms/new"

        click_on("Meetings")

        expect(page).to have_current_path('/meetings')
      end
    end
  end
end
