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
<<<<<<< HEAD

  describe 'site navigation' do
    xit 'has a navigation bar with links to other index pages' do
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

      expect(page).to have_link("Conference Manager Home")
      expect(page).to have_link("Meetings")
      expect(page).to have_link("Meeting Rooms")
      expect(page).to have_link("Presentations")
      expect(page).to have_link("Meetings")
    end

    xit 'navigates to the welcome page' do
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

      click_on("Conference Manager Home")

      expect(page).to have_current_path('/')
    end

    xit 'navigates to the meeting_rooms page' do
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

      click_on("Meetings")

      expect(page).to have_current_path('/meeting_rooms')
    end

    xit 'navigates to the meeting rooms page' do
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

      click_on("Meeting Rooms")

      expect(page).to have_current_path('/meeting_rooms')
    end

    xit 'navigates to the meetings page' do
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

      click_on("Meetings")

      expect(page).to have_current_path('/meetings')
    end

    it 'navigates to the meetings page' do
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

      click_on("Presentations")

      expect(page).to have_current_path('/presentations')
    end
  end
=======
>>>>>>> main
end
