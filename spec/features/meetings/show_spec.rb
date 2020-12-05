require 'rails_helper'

RSpec.describe 'show meeting page' do
  it 'displays the meeting with a given id and its attributes' do
    meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                    has_projector: true,
                                    capacity: 30
                                  )
    meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                number_of_participants: 10,
                                start_time: "Monday, 10am",
                              end_time: "1 hour")

    visit "/meetings/#{meeting_1.id}"

    expect(page).to have_content(meeting_1.name)
    expect(page).to have_content(meeting_1.number_of_participants)
    expect(page).to have_content(meeting_1.start_time)
    expect(page).to have_content(meeting_1.end_time)
  end
end
