require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /meetings' do
    it 'Shows the meeting and its attributes' do
      meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                      has_projector: true,
                                      capacity: 30
                                    )
      @meeting_1 = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                  schedule: "Monday, 10am",
                                  number_of_participants: 10,
                                  duration: "1 hour")
    visit '/meetings'

    expect(page).to have_content("Meetings")
    end
  end
end
