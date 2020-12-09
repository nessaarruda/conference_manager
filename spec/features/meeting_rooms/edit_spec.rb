require 'rails_helper'

describe 'edit meeting_rooms page' do
  it 'has a form to edit the attributes of the meeting room' do
    meeting_room_1 = MeetingRoom.create(name: "Oprah",
      has_projector: true,
      capacity: 30
    )

    visit "/meeting_rooms/#{meeting_room_1.id}/edit"

    expect(page).to have_content("Update Meeting Room")
    expect(page).to have_selector('form')
    expect(page).to have_text('Meeting Room name:')
    expect(page).to have_field('metname', type: 'text')
    expect(page).to have_text('Capacity:')
    expect(page).to have_field('capacity', type: 'bigint')
  end

  it 'updates the attributes of the meeting_room' do
    meeting_room_1 = MeetingRoom.create(name: "Oprah",
      has_projector: true,
      capacity: 30
    )

    visit "/meeting_rooms/#{meeting_room_1.id}"
    click_on 'Update Meeting Room'
    expect(page).to have_button('Update Meeting Room', type: 'submit')

    fill_in('metname', with: 'Oprah')
    fill_in('capacity', with: 30)
    click_on('Update Meeting Room')

    expect(page).to have_current_path("/meeting_rooms/#{meeting_room_1.id}")
    expect(page).to have_content("Oprah")
  end

  describe 'site navigation' do
    it 'has a navigation bar with links to other index pages' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
        has_projector: true,
        capacity: 30
      )

      visit "/meeting_rooms/#{meeting_room_1.id}/edit"

      expect(page).to have_link("Conference Manager Home")
      expect(page).to have_link("Conferences")
      expect(page).to have_link("Meeting Rooms")
      expect(page).to have_link("Presentations")
      expect(page).to have_link("Meetings")
    end

    it 'navigates to the welcome page' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
        has_projector: true,
        capacity: 30
      )

      visit "/meeting_rooms/#{meeting_room_1.id}/edit"

      click_on("Conference Manager Home")

      expect(page).to have_current_path('/')
    end

    it 'navigates to the meeting_rooms page' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
        has_projector: true,
        capacity: 30
      )

      visit "/meeting_rooms/#{meeting_room_1.id}/edit"

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    it 'navigates to the meeting rooms page' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
        has_projector: true,
        capacity: 30
      )

      visit "/meeting_rooms/#{meeting_room_1.id}/edit"

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    it 'navigates to the meetings page' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
        has_projector: true,
        capacity: 30
      )

      visit "/meeting_rooms/#{meeting_room_1.id}/edit"

      click_on("Meetings")

      expect(page).to have_current_path('/meetings')
    end

    it 'navigates to the meetings page' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
        has_projector: true,
        capacity: 30
      )

      visit "/meeting_rooms/#{meeting_room_1.id}/edit"

      click_on("Meetings")

      expect(page).to have_current_path('/meetings')
    end
  end
end
