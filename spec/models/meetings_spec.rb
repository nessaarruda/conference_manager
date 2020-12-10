require 'rails_helper'

describe Meeting do
  it 'has a meeting_room' do
    should belong_to :meeting_room
  end

  it 'is deleted when its meeting room is deleted' do
    meeting_room = create(:meeting_room)
    meeting = create(:meeting, meeting_room: meeting_room)

    MeetingRoom.destroy(meeting_room.id)

    expect(MeetingRoom.all).to eq([])
    expect(Meeting.all).to eq([])
  end

  it 'selects meetings' do
    3.times do
      meeting_room = create(:meeting_room)
      5.times do
        create(:meeting, meeting_room: meeting_room)
      end
    end
    meeting_room = MeetingRoom.first

    meetings = Meeting.select_meetings(meeting_room.id, 0, :name)
    expect(meetings.to_set).to eq(meeting_room.meetings.to_set)
    expect(meetings.sort_by {|p| p.name}).to eq(meetings)
    meetings = Meeting.select_meetings(meeting_room.id, 0, nil)
    expect(meetings.to_set).to eq(meeting_room.meetings.to_set)
    meetings = Meeting.select_meetings(nil, 0, :name)
    expect(meetings.to_set).to eq(Meeting.all.to_set)
    expect(meetings.sort_by {|p| p.name}).to eq(meetings)
    meetings = Meeting.select_meetings(nil, 0, nil)
    expect(meetings.to_set).to eq(Meeting.all.to_set)
  end
end
