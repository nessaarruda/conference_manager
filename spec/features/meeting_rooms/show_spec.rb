require 'rails_helper'

describe 'As a Visitor' do
  describe 'When I visit /meeting_room/:id' do
    it 'I see the meeting_room with corresponding id and attributes' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                          has_projector: true,
                                          capacity: 30)
      meeting_room_2 = MeetingRoom.create(name: "AOC",
                                          has_projector: false,
                                          capacity: 20)
      visit '/meeting_rooms/:id'

      expect(page).to have_content("#{meeting_room_1}")
      expect(page).to have_content("#{meeting_room_2}")
    end
  end
end
