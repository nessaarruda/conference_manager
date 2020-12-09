require 'rails_helper'

describe 'as a visitor' do
  describe 'show meeting_room page' do
    it 'displays the meeting_room with that id and its attributes' do
      meeting_room = MeetingRoom.create!(name: "Oprah",
        has_projector: true,
        capacity: 30)

      visit "/meeting_rooms/#{meeting_room.id}"

      expect(page).to have_content(meeting_room.name)
      expect(page).to have_content("Capacity: #{meeting_room.capacity}")
    end

    it 'has a link to update the meeting_room' do
      meeting_room = MeetingRoom.create!(name: "Oprah",
        has_projector: true,
        capacity: 30)

      visit "/meeting_rooms/#{meeting_room.id}"

      expect(page).to have_link("Update Meeting Room", href: "/meeting_rooms/#{meeting_room.id}/edit")

      click_link("Update Meeting Room")

      expect(page).to have_current_path("/meeting_rooms/#{meeting_room.id}/edit")
    end

    it 'can delete the meeting room record' do
      meeting_room = MeetingRoom.create!(name: "Oprah",
            has_projector: true,
            capacity: 30)

      visit "/meeting_rooms/#{meeting_room.id}"

      expect(page).to have_button("Delete Meeting Room")

      click_on("Delete Meeting Room")
      expect(page).to have_current_path("/meeting_rooms")
      expect(page).not_to have_content(meeting_room.name)
    end

    describe 'site navigation' do
      it 'has a navigation bar with links to other index pages' do
        meeting_room = MeetingRoom.create!(name: "Oprah",
              has_projector: true,
              capacity: 30)
        visit "/meeting_rooms/#{meeting_room.id}"

        expect(page).to have_link("Conference Manager Home")
        expect(page).to have_link("Conferences")
        expect(page).to have_link("Meeting Rooms")
        expect(page).to have_link("Presentations")
        expect(page).to have_link("Meetings")
      end

      it 'navigates to the welcome page' do
        meeting_room = MeetingRoom.create!(name: "Oprah",
              has_projector: true,
              capacity: 30)
        visit "/meeting_rooms/#{meeting_room.id}"

        click_on("Conference Manager Home")

        expect(page).to have_current_path('/')
      end

      it 'navigates to the meeting_rooms page' do
        meeting_room = MeetingRoom.create!(name: "Oprah",
              has_projector: true,
              capacity: 30)
        visit "/meeting_rooms/#{meeting_room.id}"

        click_on("Meeting Rooms")

        expect(page).to have_current_path('/meeting_rooms')
      end

      it 'navigates to the meeting rooms page' do
        meeting_room = MeetingRoom.create!(name: "Oprah",
              has_projector: true,
              capacity: 30)
        visit "/meeting_rooms/#{meeting_room.id}"

        click_on("Meeting Rooms")

        expect(page).to have_current_path('/meeting_rooms')
      end

      it 'navigates to the Meetings page' do
        meeting_room = MeetingRoom.create!(name: "Oprah",
              has_projector: true,
              capacity: 30)
        visit "/meeting_rooms/#{meeting_room.id}"

        click_on("Meetings")

        expect(page).to have_current_path('/meetings')
      end

      it 'navigates to the meetings page' do
        meeting_room = MeetingRoom.create!(name: "Oprah",
              has_projector: true,
              capacity: 30)
        visit "/meeting_rooms/#{meeting_room.id}"

        click_on("Meetings")

        expect(page).to have_current_path('/meetings')
      end

      it 'has a link to view its Meetings' do
        meeting_room = MeetingRoom.create!(name: "Oprah",
              has_projector: true,
              capacity: 30)
        visit "/meeting_rooms/#{meeting_room.id}"

        expect(page).to have_link("View Meetings")

        click_on("View Meetings")

        expect(page).to have_current_path("/meeting_rooms/#{meeting_room.id}/meetings")
      end

      it 'has a link to itself' do
        meeting_room = MeetingRoom.create!(name: "Oprah",
              has_projector: true,
              capacity: 30)
        visit "/meeting_rooms/#{meeting_room.id}"

        expect(page).to have_link(meeting_room.name)

        click_on(meeting_room.name)

        expect(page).to have_current_path("/meeting_rooms/#{meeting_room.id}")
      end
    end
  end
end
