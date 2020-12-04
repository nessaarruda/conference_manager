require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit /meetings' do
    it 'Shows the meeting and its attributes' do
      @meeting_1 = Meeting.create(name: "Monday Meeting",
                                  schedule: "Monday, 10am",
                                  number_of_participants: 10,
                                  duration: middle_of_day)
    visit '/meeting'

    expect(page).to have_content("Meetings")
    end
  end
end
