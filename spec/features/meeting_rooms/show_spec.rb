require 'rails_helper'

describe 'as a visitor' do
  describe 'show meeting_room page' do
    it 'displays the meeting_room with that id and its attributes' do
      meeting_room_1 = MeetingRoom.create!(name: "Oprah",
        has_projector: true,
        capacity: 30)

      visit "/meeting_rooms/#{meeting_room_1.id}"

      expect(page).to have_content(meeting_room_1.name)
      expect(page).to have_content("Capacity: #{meeting_room_1.capacity}")
    end

    it 'has a link to update the meeting_room' do
      meeting_room_1 = MeetingRoom.create!(name: "Oprah",
        has_projector: true,
        capacity: 30)

      visit "/meeting_rooms/#{meeting_room_1.id}"

      expect(page).to have_link("Update Meeting Room", href: "/meeting_rooms/#{meeting_room_1.id}/edit")

      click_link("Update Meeting Room")

      expect(page).to have_current_path("/meeting_rooms/#{meeting_room_1.id}/edit")
    end

    it 'can delete the meeting room record' do
      meeting_room_1 = MeetingRoom.create!(name: "Oprah",
            has_projector: true,
            capacity: 30)

      visit "/meeting_rooms/#{meeting_room_1.id}"

      expect(page).to have_button("Delete Meeting Room")

      click_on("Delete Meeting Room")
      expect(page).to have_current_path("/meeting_rooms")
      expect(page).not_to have_content(meeting_room_1.name)
    end
  end
end
