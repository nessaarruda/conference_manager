require 'rails_helper'

describe MeetingRoom do
  it 'has meetings' do
    should have_many :meetings
  end

  it 'selects meeting_rooms' do
    meeting_room_1 = create(:meeting_room, capacity: 10)
    meeting_room_2 = create(:meeting_room, capacity: 30)
    meeting_room_3 = create(:meeting_room, capacity: 20)
    meeting_room_4 = create(:meeting_room, capacity: 40)
    3.times { create(:meeting, meeting_room: meeting_room_2) }
    2.times { create(:meeting, meeting_room: meeting_room_4) }
    1.times { create(:meeting, meeting_room: meeting_room_1) }

    meeting_rooms = MeetingRoom.select_rooms(25, "true")
    expected = [meeting_room_2, meeting_room_4]
    expect(meeting_rooms).to eq(expected)
    meeting_rooms = MeetingRoom.select_rooms(25, nil)
    expected = [meeting_room_4, meeting_room_2]
    expect(meeting_rooms).to eq(expected)
    meeting_rooms = MeetingRoom.select_rooms(nil, "true")
    expected = [meeting_room_2, meeting_room_4, meeting_room_3, meeting_room_1]
    expect(meeting_rooms).to eq(expected)
    meeting_rooms = MeetingRoom.select_rooms(nil, nil)
    expected = [meeting_room_4, meeting_room_3, meeting_room_2, meeting_room_1]
    expect(meeting_rooms).to eq(expected)
  end
end
