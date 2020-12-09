require 'rails_helper'

describe 'Edit Meeting page' do
  it 'has a form to edit the meeting' do
    meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                    has_projector: true,
                                    capacity: 30
                                  )
    meeting = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                number_of_participants: 10,
                                start_time: "Monday, 10am",
                              end_time: "1 hour")
  visit '/meetings'

    visit "/meetings/#{meeting.id}/edit"

    expect(page).to have_content("Update #{meeting.name}")
    expect(page).to have_selector('form')
    expect(page).to have_text('Meeting Name:')
    expect(page).to have_field('mename', type: 'text')
  end

  it 'updates the attributes of the meeting' do
    meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                    has_projector: true,
                                    capacity: 30
                                  )
    meeting = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                number_of_participants: 10,
                                start_time: "Monday, 10am",
                              end_time: "1 hour")
  visit '/meetings'

    visit "/meetings/#{meeting.id}/edit"

    expect(page).to have_button('Update Meeting', type: 'submit')

    fill_in('mename', with: 'Monday Meeting')
    click_on('Update Meeting')

    expect(page).to have_current_path("/meetings/#{meeting.id}")
  end

  it 'allows you to individual attributes of the meeting' do
    meeting_room_1 = MeetingRoom.create(name: "Oprah",
                                    has_projector: true,
                                    capacity: 30
                                  )
    meeting = meeting_room_1.meetings.create!(name: "Monday Meeting",
                                number_of_participants: 10,
                                start_time: "Monday, 10am",
                              end_time: "1 hour")
  visit '/meetings'

    visit "/meetings/#{meeting.id}/edit"

    fill_in 'Meeting Name', with: 'AOC'
    click_on('Update Meeting')

    expect(page).to have_content("AOC")
  end
end
