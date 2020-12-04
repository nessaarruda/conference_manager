require 'rails_helper'

describe 'as a visitor' do
  describe 'meeting_rooms index page' do
    it "can see the name of each meeting room record in the system" do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )



      visit "/meeting_rooms"

      expect(page).to have_content("Meeting Rooms")
      expect(page).to have_link(meeting_room_1.name, href: "/meeting_rooms/#{meeting_room_1.id}")
    end

    it "has a link to create a new Meeting Room record" do
      visit "/meeting_rooms"

      expect(page).to have_link("New Meeting Room", href: '/meeting_rooms/new')
    end

    it "navigates to the /meeting_room page from the link to create a new meeting room" do
      visit "/meeting_rooms"

      click_link("New Meeting Room")

      expect(page).to have_current_path('/meeting_rooms/new')
    end
  end
end
